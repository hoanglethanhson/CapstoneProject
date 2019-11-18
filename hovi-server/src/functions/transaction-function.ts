import {Request, Response, NextFunction, Handler} from "express";
import {validateByModel} from '../utils';
import {HTTP303Error, HTTP400Error, HTTP409Error} from '../utils/httpErrors';
import {Transaction} from "../models/transaction";
import {IsNumber} from "class-validator";
import {ConstantValues} from "../utils/constant-values";
import {Room} from "../models/room";
import {RoomGroup} from "../models/room-group";
import {User} from "../models/user";
import {Building} from "../models/building";

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

        if (Number(roomId) == Number.NaN){
            next(new HTTP400Error('roomId not found.'));
        } else {
            if (await Room.repo.findOne(roomId)) {
                const room = await Room.repo.findOne(roomId);
                const roomGroup = await RoomGroup.repo.findOne(room.roomGroupId);
                const building = await Building.repo.findOne(roomGroup.buildingId);
                const hostId = building.hostId;
                if (hostId == parseInt(userId)) {
                    next(new HTTP303Error("Current user is host of the room group"));
                } else {
                    let successResponse;
                    let newTransaction;
                    const transaction = await Transaction.repo.getTransaction(userId, roomId);
                    if (transaction[0]) {
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
                        newTransaction.userId =  parseInt(userId);
                        newTransaction.roomId = parseInt(roomId);
                        newTransaction.transactionStatus = ConstantValues.DUMMY_STATUS;
                        const result = await Transaction.repo.save(newTransaction);
                        //successResponse = await Transaction.repo.findOne({transactionId: result.transactionId});
                        //res.status(200).send(successResponse);
                    }
                    //const detail = await Transaction.repo.getTransactionRoomDetail(successResponse);
                    if (newTransaction) {
                        res.status(200).send(newTransaction);
                    }
                }
            } else {
                next(new HTTP400Error('roomId not found.'));
            }
        }
    };

    static generateTransferContent: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const transactionId = req.params['transactionId'];
        if (await Transaction.repo.findOne(transactionId)) {
            const transaction = await Transaction.repo.findOne(transactionId);
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
                console.log(userUpdate);
                res.status(200).send(data);
                return data;
            }
            const data = {
                isEnough: false,
                content: "DATCOC-" + transactionId,
                moneyAmount: roomGroup.depositPrice - user.balance,
                accountNumber: ConstantValues.ADMIN_ACCOUNT_NUMBER,
                bank: ConstantValues.ADMIN_BANK
            };
            let transactionUpdate = transaction;
            transactionUpdate.transactionStatus = ConstantValues.NOT_ENOUGH_BALANCE;
            transactionUpdate = await Transaction.repo.updateById(transactionId, transactionUpdate);
            res.status(200).send(data);
            return data;
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

        let transactionUpdate = transaction;
        transactionUpdate.transactionStatus = ConstantValues.HOST_REJECTED;
        transactionUpdate = await Transaction.repo.updateById(transactionId, transaction);

        let roomUpdate = room;
        roomUpdate.roomStatus = ConstantValues.ROOM_AVAILABLE;
        roomUpdate = await Room.repo.updateById(room.roomId, roomUpdate);

        let successResponse = {
            transactionUpdate: transactionUpdate,
            roomUpdate: roomUpdate
        }

        if (successResponse) res.status(200).send(successResponse);
        else next(new HTTP400Error('transactionId not found'));
    };

    static checkInConfirmedTransaction: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const transactionId = req.params['transactionId'];
        const transaction = await Transaction.repo.findOne(transactionId);

        let transactionUpdate = transaction;
        transactionUpdate.transactionStatus = ConstantValues.HOST_DEPOSIT_TRANSFERRED;
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
