import {Request, Response, NextFunction, Handler} from "express";
import {validateByModel} from '../utils';
import {HTTP400Error} from '../utils/httpErrors';
import {BankTransferHistory} from "../models/bank-transfer-history";

export default class BankTransferHistoryFunction {
    static getBankTransferHistories: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const bankTransferHistories = await BankTransferHistory.repo.find();
        if (bankTransferHistories.length != 0) res.status(200).send(bankTransferHistories);
        else next(new HTTP400Error('0 record.'));
    };

    static getBankTransferHistory: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const bankTransferHistoryId = req.params['bankTransferHistoryId'];
        const bankTransferHistory = await BankTransferHistory.repo.findOne(bankTransferHistoryId);

        if (bankTransferHistory) res.status(200).send(bankTransferHistory);
        else next(new HTTP400Error('bankTransferHistoryId not found.'));
    };

    static createBankTransferHistory: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const error = await validateByModel(BankTransferHistory, body);

        if (error) next(error);
        else {
            const newBankTransferHistory = await BankTransferHistory.repo.save(body);
            const successResponse = await BankTransferHistory.repo.findOne({transferId: newBankTransferHistory.transferId});
            res.status(200).send(successResponse);
        }
    };

    static updateBankTransferHistory: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const bankTransferHistoryId = req.params['bankTransferHistoryId'];
        const successResponse = await BankTransferHistory.repo.updateById(bankTransferHistoryId, body);

        if (successResponse) res.status(200).send(successResponse);
        else next(new HTTP400Error('bankTransferHistoryId not found'));
    };

    static deleteBankTransferHistory: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const bankTransferHistoryId = req.params['bankTransferHistoryId'];
        const successResponse = await BankTransferHistory.repo.delete(bankTransferHistoryId);

        if (successResponse.affected != 0) res.status(200).send("Delete bankTransferHistory successfully !");
        else next(new HTTP400Error('bankTransferHistoryId not found'));
    };
}
