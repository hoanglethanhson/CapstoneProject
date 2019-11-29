import {Handler, NextFunction, Request, Response} from 'express';
import {validateByModel} from '../utils';
import {HTTP400Error, HTTP404Error} from '../utils/httpErrors';
import {Building} from '../models/building';

export default class BuildingFunction {
    static getBuildings: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const buildings = await Building.repo.find();
        if (buildings.length != 0) res.status(200).send(buildings);
        else next(new HTTP404Error('0 record.'));
    };

    static getBuilding: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const typeId = req.params['buildingTypeId'];
        const hostId = req['currentUserId'];
        console.log(typeId);
        console.log(hostId);

        const buildings = await Building.repo.getBuildingInformation(Number(typeId), hostId);
        if (buildings) {
            const dataResponse = buildings.map(data => {
                const {id, typeId, buildingName, buildingServices, floorQuantity, roomGroups, province, district, ward, addressDescription, detailedAddress, location} = data;
                return roomGroups.map(value => {
                    return {
                        ...value,
                        buildingServices,
                        building: {
                            id,
                            typeId,
                            buildingName,
                            floorQuantity,
                            province,
                            district,
                            ward,
                            addressDescription,
                            detailedAddress,
                            location
                        },
                    };
                });
            });
            const merged = [].concat.apply([], dataResponse);
            res.status(200).send(merged);
        } else next(new HTTP404Error('buildingId not found.'));
    };

    static createBuilding: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const error = await validateByModel(Building, body);
        console.log(body);

        body['hostId'] = req['currentUserId'];
        body['hostId'] = body['hostId'] ? body['hostId'] : 3;

        if (error) next(error);
        else {
            const newBuilding = await Building.repo.save(body);
            if (newBuilding) {
                const successResponse = await Building.repo.findOne({id: newBuilding.id});
                res.status(200).send(successResponse);
            } else next(new HTTP400Error('Can not create building'));
        }
    };

    static updateBuilding: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const buildingId = req.params['buildingId'];
        const successResponse = await Building.repo.updateById(buildingId, body);

        if (successResponse) res.status(200).send(successResponse);
        else next(new HTTP404Error('BuildingId not found'));
    };

    static deleteBuilding: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const buildingId = req.params['buildingId'];
        const successResponse = await Building.repo.delete(buildingId);

        if (successResponse.affected != 0) res.status(200).send('Delete building successfully !');
        else next(new HTTP404Error('Building not found'));
    };

    static getHostBuildings: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const userId = req['currentUserId'];
        const buildings = await Building.repo.find({hostId: userId});
        let listData = [];
        for (const building of buildings) {
            const element = {
                buildingId: building.id,
                title: building.buildingName
            }
            listData.push(element);
        }

        if (listData) res.status(200).send(listData);
        else next(new HTTP404Error('No buildings'));
    };
}
