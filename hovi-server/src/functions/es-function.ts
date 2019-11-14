import {Handler, NextFunction, Request, Response} from 'express';
import {HTTP404Error} from '../utils/httpErrors';
import {Building} from '../models/building';
import {Client} from 'elasticsearch';
import config from '../../config';
import {buildingTitle} from '../utils';

/**
 * Create connecting to elasticSearch
 */
const client = new Client({
    host: config.ES_ENDPOINT,
});

/**
 * Create rooms index
 */
const ROOMS_INDEX = 'rooms';
/**
 * Create rooms type for index
 */
const ROOMS_TYPE = 'doc';

export default class EsFunction {

    /**
     *
     * @param req
     * @param res
     * @param next
     */
    static createRoomES: Handler = async (req: Request, res: Response, next: NextFunction) => {
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
                        roomImages: dataRoomImages,
                        updatedAt: Math.round(createdAt.getTime() / 1000),
                        name: buildingTitle(buildingName, province, district, ward),
                    };
                });

                // format documents (settings id of documents)
                const documents = posts.reduce(
                    (res, {id, ...doc}) => res.concat([
                        {update: {_id: id}},
                        {
                            doc, doc_as_upsert: true,
                        },
                    ]),
                    [],
                );

                // using bulk (elasticSearch) to create multiple locations at once
                client.bulk({
                    index: ROOMS_INDEX,
                    type: ROOMS_TYPE,
                    body: documents,
                }).then(response => {
                    console.debug(response);
                    res.status(200).send(response);
                }).catch(error => {
                    console.log(error.message);
                    next(new HTTP404Error(error.message));
                });
            } else next(new HTTP404Error('Building id not found.'));
        }
    };
}
