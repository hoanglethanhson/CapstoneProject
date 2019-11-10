import {Request, Response, NextFunction, Handler} from "express";
import {validateByModel} from '../utils';
import {HTTP400Error} from '../utils/httpErrors';
import {Transaction} from "../models/transaction";
import {IsNumber} from "class-validator";
import {ConstantValues} from "../utils/constant-values";
import {Room} from "../models/room";

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
                let successResponse;
                const transaction = await Transaction.repo.getTransaction(userId, roomId);
                if (transaction[0]) {
                    //console.log(transaction[0]);
                    let newTransaction = transaction[0];
                    newTransaction.transactionStatus = ConstantValues.ACCEPT_WAITING;
                    //console.log(newTransaction);
                    successResponse = await Transaction.repo.updateById(transaction[0].transactionId, newTransaction);
                    //res.status(200).send(successResponse);
                } else {
                    //console.log("else branch");
                    let newTransaction = new Transaction();
                    newTransaction.userId = userId;
                    newTransaction.roomId = parseInt(roomId);
                    newTransaction.transactionStatus = ConstantValues.ACCEPT_WAITING;
                    const result = await Transaction.repo.save(newTransaction);
                    successResponse = await Transaction.repo.findOne({transactionId: result.transactionId});
                    //res.status(200).send(successResponse);
                }
                const room = await Room.repo.findOne(roomId);
                let updateRoom = room;
                updateRoom.roomStatus = ConstantValues.ROOM_NOT_AVAILABLE;
                updateRoom = await Room.repo.updateById(roomId, updateRoom);
                console.log(updateRoom);
                const detail = await Transaction.repo.getTransactionRoomDetail(successResponse.transactionId);
                //console.log(Array.isArray(rooms));
                res.status(200).send(detail);

            } else {
                next(new HTTP400Error('roomId not found.'));
            }
        }

    };

    static generateTransferContent: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const transactionId = req.params['transactionId'];
        if (await Transaction.repo.findOne(transactionId)) {
            const successResponse = "DATCOC-" + transactionId;
            if (successResponse) res.status(200).send(successResponse);
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


    static deleteTransaction: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const transactionId = req.params['transactionId'];
        const successResponse = await Transaction.repo.delete(transactionId);

        if (successResponse.affected != 0) res.status(200).send("Delete transaction successfully !");
        else next(new HTTP400Error('transactionId not found'));
    };
}
