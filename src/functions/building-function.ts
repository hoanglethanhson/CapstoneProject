import {Handler, NextFunction, Request, Response} from 'express';
import {buildingTitle, validateByModel, SearchServiceRequest} from '../utils';
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
        const buildings = await Building.repo.find({hostId: userId, typeId: 3});
        let listData = [];
        for (const building of buildings) {
            const element = {
                buildingId: building.id,
                title: building.buildingName
            };
            listData.push(element);
        }

        if (listData) res.status(200).send(listData);
        else next(new HTTP404Error('No buildings'));
    };

    static createRoomES: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const idToken = req['idToken'];
        const buildingId = req.params['buildingId'];

        if (isNaN(Number(buildingId))) next(new HTTP404Error('Building id is invalid.'));
        else {
            const building = await Building.repo.getBuildingInformationById(Number(buildingId));
            if (building) {
                const {typeId, buildingName, location, roomGroups, province, district, ward} = building;
                const dataLocation = {
                    province: JSON.parse(province)[1],
                    district: JSON.parse(district)[1],
                    ward: JSON.parse(ward)[1],
                    coordinates: {
                        lat: String(location).split(',')[0],
                        lon: String(location).split(',')[1],
                    },
                };

                const posts = roomGroups.map(roomGroup => {
                    const {id, gender, rentPrice, area, direction, capacity, roomAmenities, roomImages, createdAt} = roomGroup;
                    const dataRoomImages = roomImages.map(data => data.imageUrl);
                    const amenities = roomAmenities.map(data => {
                        const {id, unusableName, usableName} = data.amenities;
                        return {id, name: unusableName ? unusableName : usableName};
                    });

                    let date = createdAt ? Math.round(createdAt.getTime()) : Math.round(new Date().getTime());
                    if (id < 30) date = new Date().getTime();

                    // const date = createdAt ? Math.round(createdAt.getTime()) : Math.round(new Date().getTime());

                    return {
                        id,
                        typeId,
                        gender,
                        rentPrice,
                        area,
                        direction,
                        capacity,
                        amenities,
                        ...dataLocation,
                        viewAmount: 0,
                        roomImages: dataRoomImages,
                        name: buildingTitle(buildingName, province, district, ward),
                        updatedAt: date
                    };
                });

                SearchServiceRequest('/rooms/create', 'POST', idToken)
                    .then(data => res.status(200).send(data))
                    .catch(error => next(new HTTP400Error(error)));
            } else next(new HTTP404Error('Building id not found.'));
        }
    };
}
