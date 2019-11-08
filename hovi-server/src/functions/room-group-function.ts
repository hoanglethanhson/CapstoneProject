import { Request, Response, NextFunction, Handler } from 'express';
import { isObject } from '../utils';
import { HTTP400Error } from '../utils/httpErrors';
import { RoomGroup } from '../models/room-group';
import { Room } from '../models/room';
import { ConstantValues } from '../utils/constant-values';

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

  /**
   * Create or update room group from client
   * @param req
   * @param res
   * @param next
   */
  static createRoomGroup: Handler = async (req: Request, res: Response, next: NextFunction) => {
    const { buildingId, roomGroupId, data } = req.body || {};

    /**
     * format data for room (Nhà nguyên căn, Căn hộ chung cư => Thuê cả nhà [1 đơn vị])
     * Khu nhà trọ => nhiều đơn vị
     */
    let roomData = ['Thuê cả nhà'];
    if (data.roomNames && Array.isArray(data.roomNames) && data.roomNames.length > 0) roomData = data.roomNames;

    /**
     * Check roomGroupId if room group is exits when update else create
     */
    if (roomGroupId) {
      // update room group information
      const successResponse = await RoomGroup.repo.updateById(roomGroupId, data);

      let roomCreateData = [], updatePromise = [];
      for (let i = 0; i < roomData.length; i++) {
        if (isObject(roomData[i])) updatePromise.push(Room.repo.updateById(roomData[i]['roomId'], {
          roomStatus: roomData[i]['roomStatus'],
          roomName: roomData[i]['roomName'],
        }));

        else roomCreateData.push({
          roomGroupId, roomName: roomData[i], roomStatus: ConstantValues.ROOM_AVAILABLE,
        });
      }

      if (roomCreateData.length) await Room.repo.createMultipleRooms(roomCreateData, roomGroupId);
      await Promise.all(updatePromise);

      if (!successResponse) next(new HTTP400Error('RoomGroupId not found'));
      res.status(200).send({
        roomGroupId, dataResponse: {
          roomGroupData: successResponse,
        },
      });
    } else {
      const newRoomGroup = await RoomGroup.repo.save({ buildingId, ...data });
      let formatRoomData = roomData.map(room => {
        return { roomGroupId: newRoomGroup.id, roomName: room, roomStatus: ConstantValues.ROOM_AVAILABLE };
      });

      const responseRoomGroup = await RoomGroup.repo.findOne({ id: newRoomGroup.id });
      const responseRoom = await Room.repo.createMultipleRooms(formatRoomData, newRoomGroup.id);

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

  static getRoomGroupTransactionDetail: Handler = async (req: Request, res: Response, next: NextFunction) => {
    const roomGroupId = req.params['roomGroupId'];
    const userId = req['currentUserId'];
    const roomGroup = await RoomGroup.repo.findOne(roomGroupId);

    if (!roomGroup) next(new HTTP400Error('roomGroupId not found.'));
    const roomGroupDetail = await RoomGroup.repo.getRoomGroupTransactionDetail(roomGroupId, userId);

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
