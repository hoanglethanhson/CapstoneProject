import {Request, Response, NextFunction, Handler} from "express";
import {validateByModel} from '../utils';
import {HTTP400Error} from '../utils/httpErrors';
import {RoomType} from "../models/building-type";

export default class RoomTypeFunction {
    static getRoomTypes: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const roomTypes = await RoomType.repo.find();

        console.log(req);
        if (roomTypes.length != 0) res.status(200).send(roomTypes);
        else next(new HTTP400Error('0 record.'));
    };

    static getRoomType: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const roomTypeId = req.params['roomTypeId'];
        const roomType = await RoomType.repo.findOne(roomTypeId);

        if (roomType) res.status(200).send(roomType);
        else next(new HTTP400Error('roomTypeId not found.'));
    };

    static createRoomType: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const error = await validateByModel(RoomType, body);

        if (error) next(error);
        else {
            const checkRoomType = await RoomType.repo.findOne({type: body['type']});

            if (checkRoomType) next(new HTTP400Error('Room type already exists'));
            else {
                const newRoomType = await RoomType.repo.save(body);
                const successResponse = await RoomType.repo.findOne({id: newRoomType.id});
                res.status(200).send(successResponse);
            }
        }
    };

    static updateRoomType: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const roomTypeId = req.params['roomTypeId'];
        const successResponse = await RoomType.repo.updateById(roomTypeId, body);

        if (successResponse) res.status(200).send(successResponse);
        else next(new HTTP400Error('roomTypeId not found'));
    };

    static deleteRoomType: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const roomTypeId = req.params['roomTypeId'];
        const successResponse = await RoomType.repo.delete(roomTypeId);

        if (successResponse.affected != 0) res.status(200).send("Delete room type successfully !");
        else next(new HTTP400Error('roomType not found'));
    };
}
