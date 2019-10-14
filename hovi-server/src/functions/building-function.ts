import {Request, Response, NextFunction, Handler} from "express";
import {validateByModel} from '../utils';
import {HTTP400Error} from '../utils/httpErrors';
import {Building} from "../models/building";

export default class BuildingFunction {
    static getBuildings: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const buildings = await Building.repo.find();
        if (buildings.length != 0) res.status(200).send(buildings);
        else next(new HTTP400Error('0 record.'));
    };

    static getBuilding: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const buildingId = req.params['buildingId'];
        const building = await Building.repo.findOne(buildingId);

        if (building) res.status(200).send(building);
        else next(new HTTP400Error('buildingId not found.'));
    };

    static createBuilding: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const error = await validateByModel(Building, body);

        if (error) next(error);
        else {
                const newBuilding = await Building.repo.save(body);
                const successResponse = await Building.repo.findOne({id: newBuilding.id});
                res.status(200).send(successResponse);
        }
    };

    static updateBuilding: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const buildingId = req.params['buildingId'];
        const successResponse = await Building.repo.updateById(buildingId, body);

        if (successResponse) res.status(200).send(successResponse);
        else next(new HTTP400Error('BuildingId not found'));
    };

    static deleteBuilding: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const buildingId = req.params['buildingId'];
        const successResponse = await Building.repo.delete(buildingId);

        if (successResponse.affected != 0) res.status(200).send("Delete building successfully !");
        else next(new HTTP400Error('Building not found'));
    };
}
