import {Request, Response, NextFunction, Handler} from "express";
import {validateByModel} from '../utils';
import {HTTP400Error} from '../utils/httpErrors';
import {RoomGroup} from "../models/room_group";

export default class RoomGroupFunction {
    static getRoomGroups: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const roomGroups = await RoomGroup.repo.find();
        if (roomGroups.length != 0) res.status(200).send(roomGroups);
        else next(new HTTP400Error('0 record.'));
    };

    static getRoomGroup: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const roomGroupId = req.params['roomGroupId'];
        const roomGroup = await RoomGroup.repo.findOne(roomGroupId);

        if (roomGroup) res.status(200).send(roomGroup);
        else next(new HTTP400Error('roomGroupId not found.'));
    };

    static getRoomGroupDetail: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const roomGroupId = req.params['roomGroupId'];
        const roomGroupDetail = await RoomGroup.repo.getRoomGroupDetail(roomGroupId);

        if (roomGroupDetail) res.status(200).send(roomGroupDetail);
        else next(new HTTP400Error('roomGroupId not found.'));
    };

    static createRoomGroup: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const error = await validateByModel(RoomGroup, body);

        if (error) next(error);
        else {
            const newRoomGroup = await RoomGroup.repo.save(body);
            const successResponse = await RoomGroup.repo.findOne({id: newRoomGroup.id});
            res.status(200).send(successResponse);
        }
    };

    static updateRoomGroup: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const roomGroupId = req.params['roomGroupId'];
        const successResponse = await RoomGroup.repo.updateById(roomGroupId, body);

        if (successResponse) res.status(200).send(successResponse);
        else next(new HTTP400Error('RoomGroupId not found'));
    };

    static deleteRoomGroup: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const roomGroupId = req.params['roomGroupId'];
        const successResponse = await RoomGroup.repo.delete(roomGroupId);

        if (successResponse.affected != 0) res.status(200).send("Delete room group successfully !");
        else next(new HTTP400Error('Room group not found'));
    };
}
