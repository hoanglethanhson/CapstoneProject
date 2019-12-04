import {Request, Response, NextFunction, Handler} from "express";
import {validateByModel} from '../utils';
import {HTTP400Error} from '../utils/httpErrors';
import {SystemInformation} from "../models/system-information";

export default class SystemInformationFunction {
    static getSystemInformations: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const systemInformations = await SystemInformation.repo.find();

        if (systemInformations.length != 0) res.status(200).send(systemInformations);
        else next(new HTTP400Error('0 record.'));
    };

    static getSystemInformation: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const systemInformationId = req.params['infoId'];
        const systemInformation = await SystemInformation.repo.findOne(systemInformationId);

        if (systemInformation) res.status(200).send(systemInformation);
        else next(new HTTP400Error('systemInformationId not found.'));
    };

    static createSystemInformation: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const error = await validateByModel(SystemInformation, body);

        if (error) next(error);
        else {
            const newSystemInformation = await SystemInformation.repo.save(body);
            const successResponse = await SystemInformation.repo.findOne(newSystemInformation.accountId);
            res.status(200).send(successResponse);
        }
    };

    static updateSystemInformation: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const systemInformationId = req.params['infoId'];
        const successResponse = await SystemInformation.repo.updateById(systemInformationId, body);

        if (successResponse) res.status(200).send(successResponse);
        else next(new HTTP400Error('SystemInformationId not found'));
    };

    static deleteSystemInformation: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const systemInformationId = req.params['infoId'];
        const successResponse = await SystemInformation.repo.delete(systemInformationId);

        if (successResponse.affected != 0) res.status(200).send("Delete systemInformation successfully !");
        else next(new HTTP400Error('SystemInformation not found'));
    };
}
