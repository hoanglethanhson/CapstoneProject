import {Request, Response, NextFunction, Handler} from "express";
import DBFirebase from '../utils/DBFirebase';
import {HTTP303Error, HTTP400Error} from '../utils/httpErrors';
import {Transaction} from "../models/transaction";
import {ConstantValues} from "../utils/constant-values";
import {Room} from "../models/room";
import {RoomGroup} from "../models/room-group";
import {User} from "../models/user";
import {Building} from "../models/building";
import {AdminBankAccount} from "../models/admin-bank-account";


export default class TransactionFunction {
    static getTransactions: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const transactions = await Transaction.repo.find();
        if (transactions.length != 0) res.status(200).send(transactions);
        else next(new HTTP400Error('0 record.'));
    };

    static getTransaction: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const transactionId = req.params['transactionId'];
        const transaction = await Transaction.repo.findOne(transactionId);

        if (transaction) res.status(200).send(transaction);
        else next(new HTTP400Error('transactionId not found.'));
    };

    static createTransaction: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const userId = req['currentUserId'];
        //const userId = 7;
        const roomId = req.params['roomId'];

        if (isNaN(Number(roomId))) next(new HTTP400Error('roomId not found.'));
        else {
            if (await Room.repo.findOne(roomId)) {
                const room = await Room.repo.findOne(roomId);
                const roomGroup = await RoomGroup.repo.findOne(room.roomGroupId);
                const building = await Building.repo.findOne(roomGroup.buildingId);
                const hostId = building.hostId;
                if (hostId == parseInt(userId)) next(new HTTP303Error("Current user is host of the room group"));
                else {
                    let successResponse;
                    let newTransaction;
                    const transaction = await Transaction.repo.getTransaction(userId, roomId);
                    if (transaction[0]) {
                        const status = transaction[0].transactionStatus;
                        if (status != ConstantValues.DUMMY_STATUS && status != ConstantValues.CHECKED_OUT && status != ConstantValues.HOST_REJECTED) {
                            res.status(200).send(transaction[0]);
                            return;
                        }
                        console.log("if branch");
                        console.log(transaction[0]);
                        newTransaction = transaction[0];
                        newTransaction.transactionStatus = ConstantValues.DUMMY_STATUS;
                        //console.log(newTransaction);
                        successResponse = await Transaction.repo.updateById(transaction[0].transactionId, newTransaction);
                        res.status(200).send(successResponse);
                    } else {
                        console.log("else branch");
                        newTransaction = new Transaction();
                        newTransaction.userId = parseInt(userId);
                        newTransaction.roomId = parseInt(roomId);
                        newTransaction.transactionStatus = ConstantValues.DUMMY_STATUS;
                        const result = await Transaction.repo.save(newTransaction);

                        console.log('/messages/' + result.transactionId);
                        // create conversation in firebase
                        const notification = {
                            receiverId: hostId,
                            notificationId: result.transactionId,
                            content: {
                                title: building.buildingName,
                                description: 'Có khách liên hệ thuê phòng.'
                            }
                        };

                        DBFirebase.pushNotification(notification)
                            .then(data => {
                                console.log(data);
                                res.status(200).send(result);
                            }).catch(err => {
                            console.log(err);
                            next(new HTTP400Error(err.toString()))
                        });
                    }
                }
            } else next(new HTTP400Error('roomId not found.'));
        }
    };

    static generateTransferContent: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const transactionId = req.params['transactionId'];
        if (await Transaction.repo.findOne(transactionId)) {
            const transaction = await Transaction.repo.findOne(transactionId);
            const userId = req['currentUserId'];
            if (transaction.userId != parseInt(userId)) {
                next(new HTTP303Error('Not your transaction.'));
                return;
            }
            const room = await Room.repo.findOne(transaction.roomId);
            const roomGroup = await RoomGroup.repo.findOne(room.roomGroupId);
            const user = await User.repo.findOne(transaction.userId);
            if (user.balance >= roomGroup.depositPrice) {
                const data = {
                    isEnough: true
                };
                let userUpdate = user;
                userUpdate.balance = user.balance - roomGroup.depositPrice;
                userUpdate = await User.repo.updateById(user.id, userUpdate);
                //console.log(userUpdate);

                let transactionUpdate = transaction;
                transactionUpdate.transactionStatus = ConstantValues.ENOUGH_BALANCE;
                transactionUpdate = await Transaction.repo.updateById(transactionId, transactionUpdate);

                res.status(200).send(transactionUpdate);
                return transactionUpdate;
            }
            const adminBankAccounts = await AdminBankAccount.repo.find();
            let dataArray = [];
            for (const account of adminBankAccounts) {
                const content = {
                    isEnough: false,
                    content: "DATCOC-" + transactionId,
                    moneyAmount: roomGroup.depositPrice - user.balance,
                    accountNumber: account.accountNumber,
                    bank: account.bank,
                    holderName: account.holderName
                };
                dataArray.push(content);
            }
            let transactionUpdate = transaction;
            transactionUpdate.transactionStatus = ConstantValues.NOT_ENOUGH_BALANCE;
            transactionUpdate = await Transaction.repo.updateById(transactionId, transactionUpdate);
            res.status(200).send(dataArray);
            return dataArray;
        } else
            next(new HTTP400Error('transactionId not found'));
    };


    static updateTransaction: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const transactionId = req.params['transactionId'];
        const successResponse = await Transaction.repo.updateById(transactionId, body);

        if (successResponse) res.status(200).send(successResponse);
        else next(new HTTP400Error('transactionId not found'));
    };

    static updateTransactionAndLockRoom: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const transactionId = req.params['transactionId'];
        const roomId = body.roomId;
        const roomBody = await Room.repo.findOne(roomId);
        const availableRooms = await Room.repo.getAvailableRoomsInGroup(roomBody.roomGroupId);
        if (roomBody.roomStatus == ConstantValues.ROOM_NOT_AVAILABLE) {
            res.status(303).send(availableRooms);
            return;
        }

        const userId = req['currentUserId'];
        if (!await User.repo.isUserAuthorized(userId, transactionId)) {
            next(new HTTP303Error('Not your transaction.'));
            return;
        }

        const successResponse = await Transaction.repo.updateById(transactionId, body);

        const transaction = await Transaction.repo.findOne(transactionId);
        let transactionUpdate = transaction;
        transactionUpdate.transactionStatus = ConstantValues.ACCEPT_WAITING;
        transactionUpdate = await Transaction.repo.updateById(transaction.transactionId, transactionUpdate);

        const room = await Room.repo.findOne(transaction.roomId);
        let updateRoom = room;
        updateRoom.roomStatus = ConstantValues.ROOM_NOT_AVAILABLE;
        updateRoom = await Room.repo.updateById(room.roomId, updateRoom);

        if (successResponse) res.status(200).send(transactionUpdate);
        else next(new HTTP400Error('transactionId not found'));
    };

    static rejectTransaction: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const transactionId = req.params['transactionId'];
        const transaction = await Transaction.repo.findOne(transactionId);
        const room = await Room.repo.findOne(transaction.roomId);
        const userId = req['currentUserId'];
        if (!await User.repo.isHostAuthorized(userId, transactionId)) {
            next(new HTTP303Error('Not your transaction.'));
            return;
        }

        let transactionUpdate = transaction;
        transactionUpdate.transactionStatus = ConstantValues.HOST_REJECTED;
        transactionUpdate = await Transaction.repo.updateById(transactionId, transaction);

        let roomUpdate = room;
        roomUpdate.roomStatus = ConstantValues.ROOM_AVAILABLE;
        roomUpdate = await Room.repo.updateById(room.roomId, roomUpdate);

        let successResponse = {
            transactionUpdate: transactionUpdate
        }

        if (successResponse) res.status(200).send(successResponse);
        else next(new HTTP400Error('transactionId not found'));
    };

    static checkInConfirmedTransaction: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const transactionId = req.params['transactionId'];
        const transaction = await Transaction.repo.findOne(transactionId);
        const room = await Room.repo.findOne(transaction.roomId);

        const userId = req['currentUserId'];
        console.log(userId);
        if (!await User.repo.isTenantAuthorized(userId, transactionId)) {
            next(new HTTP303Error('Not your transaction.'));
            return;
        }

        let transactionUpdate = transaction;
        transactionUpdate.transactionStatus = ConstantValues.HOST_DEPOSIT_TRANSFERRED;
        transactionUpdate = await Transaction.repo.updateById(transactionId, transaction);

        let roomUpdate = room;
        roomUpdate.roomStatus = ConstantValues.ROOM_AVAILABLE;
        roomUpdate = await Room.repo.updateById(room.roomId, roomUpdate);

        let successResponse = {
            transactionUpdate: transactionUpdate,
        }

        if (successResponse) res.status(200).send(successResponse);
        else next(new HTTP400Error('transactionId not found'));
    };

    static checkOutConfirmedTransaction: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const transactionId = req.params['transactionId'];
        const transaction = await Transaction.repo.findOne(transactionId);

        const userId = req['currentUserId'];
        if (!await User.repo.isHostAuthorized(userId, transactionId)) {
            next(new HTTP303Error('Not your transaction.'));
            return;
        }

        let transactionUpdate = transaction;
        transactionUpdate.transactionStatus = ConstantValues.CHECKED_OUT;
        transactionUpdate = await Transaction.repo.updateById(transactionId, transaction);

        let successResponse = {
            transactionUpdate: transactionUpdate,
        }

        if (successResponse) res.status(200).send(successResponse);
        else next(new HTTP400Error('transactionId not found'));
    };


    static deleteTransaction: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const transactionId = req.params['transactionId'];
        const successResponse = await Transaction.repo.delete(transactionId);

        if (successResponse.affected != 0) res.status(200).send("Delete transaction successfully !");
        else next(new HTTP400Error('transactionId not found'));
    };
}
