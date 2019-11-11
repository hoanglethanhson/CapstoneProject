import {Request, Response, NextFunction, Handler} from "express";
import {validateByModel} from '../utils';
import {HTTP400Error} from '../utils/httpErrors';
import {BankTransferHistory} from "../models/bank-transfer-history";
import {ConstantValues} from "../utils/constant-values";
import {Transaction} from "../models/transaction";
import {User} from "../models/user";

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
        if (!body.data.bankData || !Array.isArray(body.data.bankData)) next(new HTTP400Error('Data is not valid'));
        let error = {};

        let resultArray = [];
        //Define transfer content regex
        const transferRegex = new RegExp("^DATCOC-[0-9]{1,}$");
        console.log(body.data.bankData);
        if (Array.isArray(body.data.bankData)) {
            for (const transfer of body.data.bankData) {
                let isValidate = true;
                //check if the content match the regex
                if (!transferRegex.test(transfer.transferContent)) {
                    isValidate = false;
                }
                let transactionId;
                let userId;
                if (isValidate) {
                    transactionId = parseInt(transfer.transferContent.split("-")[1].trim());
                    //check if transactionId exists in transaction table
                    if (await Transaction.repo.findOne(transactionId) == null) {
                        isValidate = false;
                        userId = -1;
                    } else {
                        userId = await Transaction.repo.getTenantId(transactionId);
                    }
                } else {
                    userId = -1;
                }
                //If the content is invalid, set userId of the transaction to -1 (Error user)

                let senderUserId;
                let senderBank;
                let senderAccountNumber;
                let senderUserType;
                let receiverUserId;
                let receiverBank;
                let receiverAccountNumber;
                let receiverUserType;

                let moneyAmount = (transfer.credit != null)? parseFloat(transfer.credit) : parseFloat(transfer.debit);
                let transferTime = new Date(transfer.transferDate);
                let transferNote = transfer.transferContent;


                if (transfer.credit != null) {
                    senderUserId = userId;
                    senderBank = transfer.account.split("-")[1].trim();
                    senderAccountNumber = transfer.account.split("-")[0].trim();
                    senderUserType = ConstantValues.TENANT;

                    receiverUserId = ConstantValues.ADMIN_USER_ID;
                    receiverBank = ConstantValues.ADMIN_BANK;
                    receiverAccountNumber = ConstantValues.ADMIN_ACCOUNT_NUMBER;
                    receiverUserType = ConstantValues.ADMIN;

                    //add fund for user
                    if (userId != -1) {
                        const user = await User.repo.findOne(userId);
                        let userUpdate = user;
                        userUpdate.balance = user.balance + moneyAmount;
                        userUpdate = await User.repo.updateById(userId, userUpdate);
                    }

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
                    transferNote,
                    isValidate: isValidate
                };
                resultArray = resultArray.concat(result);
            }
        }

        for (let i = 0; i < resultArray.length; i++)
            error[i] = await validateByModel(BankTransferHistory, resultArray[i]);

        if (error[0]) next(new HTTP400Error(error[0]));
        else {
            await BankTransferHistoryFunction.saveRecords(resultArray);
            let validArray = [];
            for (const result of resultArray) {
                if (result.isValidate) {
                    validArray = validArray.concat(result);
                }
            }
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
