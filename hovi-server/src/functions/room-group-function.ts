import { Request, Response, NextFunction, Handler } from 'express';
import { validateByModel } from '../utils';
import { HTTP400Error } from '../utils/httpErrors';
import { RoomGroup } from '../models/room-group';
import { Room } from '../models/room';

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

  static getRoomGroupByBuildingId: Handler = async (req: Request, res: Response, next: NextFunction) => {
    const buildingId = req.params['buildingId'];
    const roomGroup = await RoomGroup.repo.find({ where: { buildingId } });

    if (roomGroup) res.status(200).send(roomGroup);
    else next(new HTTP400Error('buildingId not found.'));
  };

  static createRoomGroup: Handler = async (req: Request, res: Response, next: NextFunction) => {
    const { buildingId, roomGroupId, data } = req.body || {};

    const error = await validateByModel(RoomGroup, data);
    if (error) next(new HTTP400Error(error));

    let roomGroupData: RoomGroup, roomData = ['Thuê cả nhà'];
    if (data.roomNames && Array.isArray(data.roomNames) && data.roomNames.length > 0) roomData = data.roomNames;

    roomGroupData = { ...data, quantity: roomData.length };

    if (roomGroupId) {
      const successResponse = await RoomGroup.repo.updateById(roomGroupId, roomGroupData);
      if (successResponse) res.status(200).send({
        roomGroupId, dataResponse: { roomGroupData: successResponse },
      });
      else next(new HTTP400Error('RoomGroupId not found'));

    } else {
      const newRoomGroup = await RoomGroup.repo.save({ buildingId, ...roomGroupData });
      let formatRoomData = roomData.map(room => {
        return { roomGroupId: newRoomGroup.id, roomName: room };
      });

      const responseRoomGroup = await RoomGroup.repo.findOne({ id: newRoomGroup.id });
      const responseRoom = await Room.repo.createMultipleRooms(formatRoomData);

      res.status(200).send({
        roomGroupId: newRoomGroup.id,
        dataResponse: {
          roomGroupData: responseRoomGroup,
          roomData: responseRoom,
        },
      });
    }
  };

  static getRoomGroupDetail: Handler = async (req: Request, res: Response, next: NextFunction) => {
    const roomGroupId = req.params['roomGroupId'];
    const roomGroup = await RoomGroup.repo.findOne(roomGroupId);

    if (!roomGroup) next(new HTTP400Error('roomGroupId not found.'));
    const roomGroupDetail = await RoomGroup.repo.getRoomGroupDetail(roomGroupId, roomGroup);

    if (roomGroupDetail) res.status(200).send(roomGroupDetail);
    else next(new HTTP400Error('error get details.'));
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

    if (successResponse.affected != 0) res.status(200).send('Delete room group successfully !');
    else next(new HTTP400Error('Room group not found'));
  };
}
