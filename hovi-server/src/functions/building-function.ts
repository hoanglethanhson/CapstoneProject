import { Handler, NextFunction, Request, Response } from 'express';
import { validateByModel } from '../utils';
import { HTTP400Error } from '../utils/httpErrors';
import { Building } from '../models/building';

export default class BuildingFunction {
  static getBuildings: Handler = async (req: Request, res: Response, next: NextFunction) => {
    const buildings = await Building.repo.find();
    if (buildings.length != 0) res.status(200).send(buildings);
    else next(new HTTP400Error('0 record.'));
  };

  static getBuilding: Handler = async (req: Request, res: Response, next: NextFunction) => {
    const typeId = req.params['buildingTypeId'];
    const hostId = req['currentUserId'];
    console.log(typeId);
    console.log(hostId);

    const building = await Building.repo.getBuildingInformation(Number(typeId), hostId);
    if (building) {
      const dataResponse = building.map(data => {
        const { id, typeId, buildingName, buildingServices, floorQuantity, roomGroups, province, district, ward, addressDescription, detailedAddress } = data;
        return roomGroups.map(value => {
          return {
            ...value,
            buildingServices,
            building: {
              id, typeId, buildingName, floorQuantity, province, district, ward, addressDescription, detailedAddress,
            },
          };
        });
      });
      const merged = [].concat.apply([], dataResponse);
      res.status(200).send(merged);
    } else next(new HTTP400Error('buildingId not found.'));
  };

  static createBuilding: Handler = async (req: Request, res: Response, next: NextFunction) => {
    const body = req.body || {};
    const error = await validateByModel(Building, body);
    console.log(body);

    body['hostId'] = req['currentUserId'];
    body['hostId'] = body['hostId'] ? body['hostId'] : 3;

    if (error) next(error);
    else {
      if (body['buildingId']) {
        const successResponse = await Building.repo.updateById(body['buildingId'], body);
        res.status(200).send(successResponse);
      } else {
        const newBuilding = await Building.repo.save(body).catch(err => console.log(err));
        const successResponse = await Building.repo.findOne({ id: newBuilding.id });
        res.status(200).send(successResponse);
      }
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

    if (successResponse.affected != 0) res.status(200).send('Delete building successfully !');
    else next(new HTTP400Error('Building not found'));
  };
}
