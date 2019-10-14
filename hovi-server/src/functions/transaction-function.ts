import {Request, Response, NextFunction, Handler} from "express";
import {validateByModel} from '../utils';
import {HTTP400Error} from '../utils/httpErrors';
import {Transaction} from "../models/transaction";

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
        const body = req.body || {};
        const error = await validateByModel(Transaction, body);

        if (error) next(error);
        else {
                const newTransaction = await Transaction.repo.save(body);
                const successResponse = await Transaction.repo.findOne({transactionId: newTransaction.transactionId});
                res.status(200).send(successResponse);
        }
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
