import { Request, Response, NextFunction, Handler } from 'express';
import GoogleStorage from '../utils/gcp';
import config from '../../config';
import { HTTP400Error } from '../utils/httpErrors';
import { RoomImage } from '../models/room-image';

const googleStorage = new GoogleStorage(config.BUCKET_NAME);

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

  static uploadImage: Handler = async (req: Request, res: Response, next: NextFunction) => {
    let { roomGroupId } = req.body;
    const files = req['files'];
    console.log(req);
    console.log(req.body);

    if (!files) next(new HTTP400Error('List images not found.'));
    else if (!roomGroupId) next(new HTTP400Error('Room group id not found.'));

    let promises = [];
    files.forEach(file => promises.push(googleStorage.uploadFileToGoogleStoragePromise(file, roomGroupId)));
    Promise.all(promises)
      .then(result => {
        console.debug(result);
        res.status(200).send({
          status: 200,
          urls: result,
        });
      })
      .catch(error => {
        console.log(error);
        res.status(404).send(error);
      });
  };

  static createRoomImage: Handler = async (req: Request, res: Response, next: NextFunction) => {
    const { roomGroupId, urls } = req.body;
    let createRoomGroupImagePromise = [];
    for (let i = 0; i < urls.length; i++)
      createRoomGroupImagePromise.push(RoomImage.repo.save({
        roomGroupId,
        imageUrl: urls[i],
      }));

    Promise.all(createRoomGroupImagePromise).then(response => {
      res.status(200).send(response);
    });
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

    if (successResponse.affected != 0) res.status(200).send('Delete room image successfully !');
    else next(new HTTP400Error('Room image not found'));
  };
}
