import {Request, Response, NextFunction, Handler} from "express";
import {validateByModel} from '../utils';
import {HTTP303Error, HTTP400Error} from '../utils/httpErrors';
import {Room} from "../models/room";
import {RoomGroup} from "../models/room-group";
import {Building} from "../models/building";
import {ConstantValues} from "../utils/constant-values";

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

    static getManagementRooms: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const keySent = req.params['keySent'];
        const userId = req['currentUserId'];
        //const userId = 15;
        console.log(userId);
        const roomList = await Room.repo.getManagementRooms(userId, keySent);

        if (roomList) res.status(200).send(roomList);
        else next(new HTTP400Error('roomId not found.'));
    };

    static getRoomsTenant: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const key = req.params['key'];
        const userId = req['currentUserId'];
        //const userId = 1;
        console.log(userId);
        const roomList = await Room.repo.getManagementRoomsForTenant(userId, key);

        if (roomList) res.status(200).send(roomList);
        else next(new HTTP400Error('roomId not found.'));
    };

    static createRoom: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const error = await validateByModel(Room, body);

        if (error) next(error);
        else {
            const newRoom = await Room.repo.save(body);
            const successResponse = await Room.repo.findOne({roomId: newRoom.roomId});
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
        const room = await Room.repo.findOne(roomId);
        const roomGroup = await RoomGroup.repo.findOne(room.roomGroupId);
        const building = await Building.repo.findOne(roomGroup.buildingId);
        const userId = req['currentUserId'];
        if (building.hostId != parseInt(userId)) {
            next(new HTTP303Error('You are not the host of this room.'));
            return;
        }
        if (room.roomStatus == ConstantValues.ROOM_NOT_AVAILABLE) {
            next(new HTTP303Error('This room is being used at the moment.'));
            return;
        }
        let roomDelete = room;
        roomDelete.roomStatus = ConstantValues.ROOM_WAS_DELETED;
        roomDelete = await Room.repo.updateById(room.roomId, roomDelete);

        if (roomDelete) res.status(200).send("Delete room successfully !");
        else next(new HTTP400Error('Room not found'));
    };
}
