import { Request, Response, NextFunction, Handler } from 'express';
import { validateByModel } from '../utils';
import { HTTP400Error } from '../utils/httpErrors';
import { BuildingService } from '../models/building_service';

export default class BuildingServiceFunction {
  static getBuildingServices: Handler = async (req: Request, res: Response, next: NextFunction) => {
    const buildingServices = await BuildingService.repo.find();
    console.log(buildingServices);

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
      const checkBuildingService = await BuildingService.repo.getOneRecord(body['buildingId'], body['serviceId']);
      if (checkBuildingService) {
        next(new HTTP400Error('This building-service pair already exists'));
      } else {
        const newBuildingService = await BuildingService.repo.save(body);
        const successResponse = await BuildingService.repo.getOneRecord(newBuildingService.buildingId, newBuildingService.serviceId);
        res.status(200).send(successResponse);
      }
    }
  };

  static createMultipleBuildingService: Handler = async (req: Request, res: Response, next: NextFunction) => {
    const body = req.body || {};
    if (!body.data || !Array.isArray(body.data)) next(new HTTP400Error('Data is not valid'));

    let error = {};
    for (let i = 0; i < body.data.length; i++)
      error[i] = await validateByModel(BuildingService, body.data[i]);

    if (error[0]) next(new HTTP400Error(error));
    else {
      let promise = [], buildingId = body.buildingId;
      for (let i = 0; i < body.data.length; i++) {
        const { serviceId } = body.data[i];
        const record = await BuildingService.repo.getOneRecord(buildingId, serviceId);
        if (record) promise.push(BuildingService.repo.updateById(buildingId, serviceId, body.data[i]));
        else promise.push(BuildingService.repo.save({ ...body.data[i], buildingId }));
      }

      Promise.all(promise).then(data => {
        res.status(200).send(data);
      }).catch(error => {
        console.log(error);
        next(new HTTP400Error(error));
      });
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

    if (successResponse.affected != 0) res.status(200).send('Delete buildingService successfully !');
    else next(new HTTP400Error('BuildingService not found'));
  };
}
