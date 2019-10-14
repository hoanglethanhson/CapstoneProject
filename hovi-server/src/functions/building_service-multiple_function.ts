import {Handler, NextFunction, Request, Response} from "express";
import {validateByModel} from "../utils";
import {BuildingService} from "../models/building_service";
import {HTTP400Error} from "../utils/httpErrors";
import {Building} from "../models/building";

export default class BuildingServiceMultipleFunction {
    static createBuildingServices: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const error = await validateByModel(BuildingService, body);

        if (error) next(error);
        else {
                const buildingId = body.buildingId;
                const isComplete = body.isComplete;
                const services = body.services;
                await Building.repo.updateStatus(buildingId, isComplete);
                const newBuildingService = await BuildingService.repo.saveMultiBuildingServices(buildingId, services);
                const successResponse = await BuildingService.repo.getServicesInBuilding(buildingId);
                console.log(successResponse);
                res.status(200).send(successResponse);
        }
    };
}