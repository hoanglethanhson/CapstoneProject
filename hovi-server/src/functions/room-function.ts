import {Request, Response, NextFunction, Handler} from "express";
import {validateByModel} from '../utils';
import {HTTP400Error} from '../utils/httpErrors';
import {Room} from "../models/room";

export default class RoomFunction {
    static getRooms: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const rooms = await Room.repo.find();

        if (rooms.length != 0) res.status(200).send(rooms);
        else next(new HTTP400Error('0 record.'));
    };

    static getRoom: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const roomId = req.params['roomId'];
        const room = await Room.repo.findOne(roomId);

        if (room) res.status(200).send(room);
        else next(new HTTP400Error('roomId not found.'));
    };

    static createRoom: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const error = await validateByModel(Room, body);

        if (error) next(error);
        else {
            const newRoom = await Room.repo.save(body);
            const successResponse = await Room.repo.findOne({id: newRoom.id});
            res.status(200).send(successResponse);
        }
    };

    static updateRoom: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const roomId = req.params['roomId'];
        const successResponse = await Room.repo.updateById(roomId, body);

        if (successResponse) res.status(200).send(successResponse);
        else next(new HTTP400Error('RoomId not found'));
    };

    static deleteRoom: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const roomId = req.params['roomId'];
        const successResponse = await Room.repo.delete(roomId);

        if (successResponse.affected != 0) res.status(200).send("Delete room successfully !");
        else next(new HTTP400Error('Room not found'));
    };
}
