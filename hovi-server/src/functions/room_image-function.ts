import {Request, Response, NextFunction, Handler} from "express";
import {validateByModel} from '../utils';
import {HTTP400Error} from '../utils/httpErrors';
import {RoomImage} from "../models/room_image";

export default class RoomImageFunction {
    static getRoomImages: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const roomImages = await RoomImage.repo.find();

        if (roomImages.length != 0) res.status(200).send(roomImages);
        else next(new HTTP400Error('0 record.'));
    };

    static getRoomImage: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const roomImageId = req.params['roomImageId'];
        const roomImage = await RoomImage.repo.findOne(roomImageId);

        if (roomImage) res.status(200).send(roomImage);
        else next(new HTTP400Error('roomImageId not found.'));
    };

    static createRoomImage: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const error = await validateByModel(RoomImage, body);

        if (error) next(error);
        else {
            const checkRoomImage = await RoomImage.repo.findOne({imageUrl: body['imageUrl']});

            if (checkRoomImage) next(new HTTP400Error('Image URL already exists'));
            else {
                const newRoomImage = await RoomImage.repo.save(body);
                const successResponse = await RoomImage.repo.findOne({id: newRoomImage.id});
                res.status(200).send(successResponse);
            }
        }
    };

    static updateRoomImage: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const roomImageId = req.params['roomImageId'];
        const successResponse = await RoomImage.repo.updateById(roomImageId, body);

        if (successResponse) res.status(200).send(successResponse);
        else next(new HTTP400Error('RoomImageId not found'));
    };

    static deleteRoomImage: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const roomImageId = req.params['roomImageId'];
        const successResponse = await RoomImage.repo.delete(roomImageId);

        if (successResponse.affected != 0) res.status(200).send("Delete room image successfully !");
        else next(new HTTP400Error('Room image not found'));
    };
}
