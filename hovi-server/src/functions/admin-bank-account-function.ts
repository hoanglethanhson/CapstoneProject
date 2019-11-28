import {Request, Response, NextFunction, Handler} from "express";
import {validateByModel} from '../utils';
import {HTTP400Error} from '../utils/httpErrors';
import {AdminBankAccount} from "../models/admin-bank-account";

export default class AdminBankAccountFunction {
    static getAdminBankAccounts: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const adminBankAccounts = await AdminBankAccount.repo.find();

        if (adminBankAccounts.length != 0) res.status(200).send(adminBankAccounts);
        else next(new HTTP400Error('0 record.'));
    };

    static getAdminBankAccount: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const adminBankAccountId = req.params['accountId'];
        const adminBankAccount = await AdminBankAccount.repo.findOne(adminBankAccountId);

        if (adminBankAccount) res.status(200).send(adminBankAccount);
        else next(new HTTP400Error('adminBankAccountId not found.'));
    };

    static createAdminBankAccount: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const error = await validateByModel(AdminBankAccount, body);

        if (error) next(error);
        else {
            const newAdminBankAccount = await AdminBankAccount.repo.save(body);
            const successResponse = await AdminBankAccount.repo.findOne(newAdminBankAccount.accountId);
            res.status(200).send(successResponse);
        }
    };

    static updateAdminBankAccount: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const adminBankAccountId = req.params['adminBankAccountId'];
        const successResponse = await AdminBankAccount.repo.updateById(adminBankAccountId, body);

        if (successResponse) res.status(200).send(successResponse);
        else next(new HTTP400Error('AdminBankAccountId not found'));
    };

    static deleteAdminBankAccount: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const adminBankAccountId = req.params['adminBankAccountId'];
        const successResponse = await AdminBankAccount.repo.delete(adminBankAccountId);

        if (successResponse.affected != 0) res.status(200).send("Delete adminBankAccount successfully !");
        else next(new HTTP400Error('AdminBankAccount not found'));
    };
}
