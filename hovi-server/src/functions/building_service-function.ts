import {Request, Response, NextFunction, Handler} from "express";
import {validateByModel} from '../utils';
import {HTTP400Error} from '../utils/httpErrors';
import {BuildingService} from "../models/building_service";

export default class BuildingServiceFunction {
    static getBuildingServices: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const buildingServices = await BuildingService.repo.find();

        if (buildingServices.length != 0) res.status(200).send(buildingServices);
        else next(new HTTP400Error('0 record.'));
    };

    static getBuildingService: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const buildingId = req.params['buildingId'];
        const buildingService = await BuildingService.repo.getServicesInBuilding(buildingId);

        if (buildingService) res.status(200).send(buildingService);
        else next(new HTTP400Error('buildingId not found.'));
    };

    static createBuildingService: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const error = await validateByModel(BuildingService, body);

        if (error) next(error);
        else {
            const checkBuildingService = await BuildingService.repo.getOneRecord(body["buildingId"], body["serviceId"]);
            if (checkBuildingService) {
                next(new HTTP400Error('This building-service pair already exists'));
            } else {
                const newBuildingService = await BuildingService.repo.save(body);
                const successResponse = await BuildingService.repo.getOneRecord(newBuildingService.buildingId, newBuildingService.serviceId);
                res.status(200).send(successResponse);
            }
        }
    };

    static updateBuildingService: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const buildingId = req.params['buildingId'];
        const serviceId = req.params['serviceId'];
        const successResponse = await BuildingService.repo.updateById(buildingId, serviceId, body);

        if (successResponse) res.status(200).send(successResponse);
        else next(new HTTP400Error('BuildingServiceId not found'));
    };

    //delete 1 record only
    static deleteBuildingService: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const buildingId = req.params['buildingId'];
        const serviceId = req.params['serviceId'];
        const successResponse = await BuildingService.repo.deleteOneRecord(buildingId, serviceId);

        if (successResponse.affected != 0) res.status(200).send("Delete buildingService successfully !");
        else next(new HTTP400Error('BuildingService not found'));
    };
}
