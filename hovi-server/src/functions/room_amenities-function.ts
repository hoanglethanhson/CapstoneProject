import {Request, Response, NextFunction, Handler} from "express";
import {validateByModel} from '../utils';
import {HTTP400Error} from '../utils/httpErrors';
import {RoomAmenities} from "../models/room_amenities";

export default class RoomAmenitiesFunction {
    static getRoomAmenitiesM: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const roomAmenities = await RoomAmenities.repo.find();

        if (roomAmenities.length != 0) res.status(200).send(roomAmenities);
        else next(new HTTP400Error('0 record.'));
    };

    static getRoomAmenities: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const roomGroupId = req.params['roomGroupId'];
        const roomAmenities = await RoomAmenities.repo.getAmenitiesDetailRoomGroup(roomGroupId);
        console.log(roomAmenities);

        if (roomAmenities) res.status(200).send(roomAmenities);
        else next(new HTTP400Error('roomGroupId not found.'));
    };

    static createRoomAmenities: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const error = await validateByModel(RoomAmenities, body);

        if (error) next(error);
        else {
            const checkRoomAmenities = await RoomAmenities.repo.getOneRecord(body["roomGroupId"], body["amenitiesId"]);
            if (checkRoomAmenities) {
                next(new HTTP400Error('This room-amenities pair already exists'));
            } else {
                const newRoomAmenities = await RoomAmenities.repo.save(body);
                const successResponse = await RoomAmenities.repo.getOneRecord(newRoomAmenities.roomGroupId, newRoomAmenities.amenitiesId);
                res.status(200).send(successResponse);
            }
        }
    };

    static updateRoomAmenities: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const roomGroupId = req.params['roomGroupId'];
        const amenitiesId = req.params['amenitiesId'];
        const successResponse = await RoomAmenities.repo.updateById(roomGroupId, amenitiesId, body);

        if (successResponse) res.status(200).send(successResponse);
        else next(new HTTP400Error('RoomAmenitiesId not found'));
    };

    //delete 1 record only
    static deleteRoomAmenities: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const roomGroupId = req.params['roomGroupId'];
        const amenitiesId = req.params['amenitiesId'];
        const successResponse = await RoomAmenities.repo.deleteOneRecord(roomGroupId, amenitiesId );

        if (successResponse.affected != 0) res.status(200).send("Delete roomAmenities successfully !");
        else next(new HTTP400Error('RoomAmenities not found'));
    };
}
