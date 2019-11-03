import {Request, Response, NextFunction, Handler} from "express";
import {validateByModel} from '../utils';
import {HTTP400Error} from '../utils/httpErrors';
import {BankTransferHistory} from "../models/bank-transfer-history";
import {ConstantValues} from "../utils/constant-values";
import {Transaction} from "../models/transaction";

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
        if (!body || !Array.isArray(body)) next(new HTTP400Error('Data is not valid'));
        let error = {};


        let resultArray = [];
        if (Array.isArray(body)) {
            for (const transfer of body) {
                const transactionId = parseInt(transfer.transferContent.split(".")[1].trim());
                const userId = await Transaction.repo.getTenantId(transactionId);

                let senderUserId;
                let senderBank;
                let senderAccountNumber;
                let senderUserType;
                let receiverUserId;
                let receiverBank;
                let receiverAccountNumber;
                let receiverUserType;


                if (transfer.credit != null) {
                    senderUserId =  userId;
                    senderBank = transfer.account.split("-")[1].trim();
                    senderAccountNumber = transfer.account.split("-")[0].trim();
                    senderUserType = ConstantValues.TENANT;

                    receiverUserId = ConstantValues.ADMIN_USER_ID;
                    receiverBank = ConstantValues.ADMIN_BANK;
                    receiverAccountNumber = ConstantValues.ADMIN_ACCOUNT_NUMBER;
                    receiverUserType = ConstantValues.ADMIN;
                } else {
                    senderUserId =  ConstantValues.ADMIN_USER_ID;
                    senderBank = ConstantValues.ADMIN_BANK;
                    senderAccountNumber = ConstantValues.ADMIN_ACCOUNT_NUMBER;
                    senderUserType = ConstantValues.ADMIN;

                    receiverUserId = userId;
                    receiverBank = transfer.account.split("-")[1].trim();
                    receiverAccountNumber = transfer.account.split("-")[0].trim();
                    receiverUserType = ConstantValues.HOST;
                }
                let moneyAmount = (transfer.credit != null)? parseFloat(transfer.credit) : parseInt(transfer.debit);
                let transferTime = new Date(transfer.transferDate);
                let transferNote = transfer.transferContent;

                const result = {
                    senderUserId,
                    senderBank,
                    senderAccountNumber,
                    senderUserType,
                    receiverUserId,
                    receiverBank,
                    receiverAccountNumber,
                    receiverUserType,
                    moneyAmount,
                    transferTime,
                    transferNote
                };
                resultArray = resultArray.concat(result);
            }
        }

        for (let i = 0; i < resultArray.length; i++)
            error[i] = await validateByModel(BankTransferHistory, resultArray[i]);

        if (error[0]) next(new HTTP400Error(error[0]));
        else {
            await BankTransferHistoryFunction.saveRecords(resultArray);
            res.status(200).send(resultArray);
        }
    };

    static async saveRecords(resultArray: any) {
        if (Array.isArray(resultArray)) {
            for (const result of resultArray) {
                await BankTransferHistory.repo.save(result);
            }
        }
    }

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
