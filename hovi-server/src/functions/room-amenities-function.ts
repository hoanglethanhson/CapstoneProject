import { Request, Response, NextFunction, Handler } from 'express';
import { validateByModel } from '../utils';
import { HTTP400Error } from '../utils/httpErrors';
import { RoomAmenities } from '../models/room-amenities';

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
    if (!body.data || !Array.isArray(body.data)) next(new HTTP400Error('Data is not valid'));
    if (!body.roomGroupId) next(new HTTP400Error('Room group id is not valid'));

    let errors = {};
    for (let i = 0; i < body.data.length; i++)
      errors[i] = await validateByModel(RoomAmenities, body.data[i]);

    console.debug(errors);

    if (errors[0]) next(new HTTP400Error(errors));
    else {
      let promise = [], roomGroupId = body.roomGroupId;

      console.debug(roomGroupId);
      for (let i = 0; i < body.data.length; i++) {
        const record = await RoomAmenities.repo.getOneRecord(roomGroupId, body.data[i]);
        if (!record) {
          let createData: RoomAmenities = new RoomAmenities();
          createData.amenitiesId = body.data[i];
          createData.roomGroupId = roomGroupId;
          promise.push(RoomAmenities.repo.save(createData));
        }
      }

      const roomAmenities = await RoomAmenities.repo.getAmenitiesDetailRoomGroup(roomGroupId);
      const formatExistRoomAmenities = roomAmenities.map(val => {
        console.log(val);
        return val.amenities_id;
      });
      let deleteRoomAmenities = formatExistRoomAmenities.filter((obj) => {
        return !body.data.includes(obj);
      });
      console.debug(formatExistRoomAmenities);
      console.debug(deleteRoomAmenities);

      for (let i = 0; i < deleteRoomAmenities.length; i++)
        promise.push(RoomAmenities.repo.deleteOneRecord(roomGroupId, deleteRoomAmenities[i]));

      Promise.all(promise).then(data => {
        res.status(200).send(data);
      }).catch(error => {
        console.log(error);
        next(new HTTP400Error(error));
      });
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
    const successResponse = await RoomAmenities.repo.deleteOneRecord(roomGroupId, amenitiesId);

    if (successResponse.affected != 0) res.status(200).send('Delete roomAmenities successfully !');
    else next(new HTTP400Error('RoomAmenities not found'));
  };
}
