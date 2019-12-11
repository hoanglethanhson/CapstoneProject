import {Request, Response, NextFunction, Handler} from "express";
import {validateByModel} from '../utils';
import {HTTP400Error} from '../utils/httpErrors';
import {Service} from "../models/service";

export default class ServiceFunction {
    static getServices: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const services = await Service.repo.find();

        if (services.length != 0) res.status(200).send(services);
        else next(new HTTP400Error('0 record.'));
    };

    static getService: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const serviceId = req.params['serviceId'];
        const service = await Service.repo.findOne(serviceId);

        if (service) res.status(200).send(service);
        else next(new HTTP400Error('serviceId not found.'));
    };

    static createService: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const error = await validateByModel(Service, body);

        if (error) next(error);
        else {
            const checkService = await Service.repo.findOne({name: body['name']});
            console.log(checkService);

            if (checkService) next(new HTTP400Error('Service already exists'));
            else {
                const newService = await Service.repo.save(body);
                const successResponse = await Service.repo.findOne({id: newService.id});
                res.status(200).send(successResponse);
            }
        }
    };

    static updateService: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const serviceId = req.params['serviceId'];
        const successResponse = await Service.repo.updateById(serviceId, body);

        if (successResponse) res.status(200).send(successResponse);
        else next(new HTTP400Error('ServiceId not found'));
    };

    static deleteService: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const serviceId = req.params['serviceId'];
        const successResponse = await Service.repo.delete(serviceId);

        if (successResponse.affected != 0) res.status(200).send("Delete service successfully !");
        else next(new HTTP400Error('Service not found'));
    };
}
