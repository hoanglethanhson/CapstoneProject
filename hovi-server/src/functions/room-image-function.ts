import {Request, Response, NextFunction, Handler} from 'express';
import GoogleStorage from '../utils/gcp';
import config from '../../config';
import {HTTP400Error, HTTP401Error} from '../utils/httpErrors';
import {RoomImage} from '../models/room-image';
import {validateByModel} from '../utils';
import {Building} from "../models/building";

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
        let {roomGroupId, listUniqueId} = req.body;
        const files = req['files'];

        if (!files) next(new HTTP400Error('List images not found.'));
        else if (!roomGroupId) next(new HTTP400Error('Room group id not found.'));
        else if (!listUniqueId || !Array.isArray(listUniqueId)) next(new HTTP400Error('List unique id is invalid'));

        let promises = [];
        /**
         * Create promise upload into google storage
         */
        files.forEach((file, index) => promises.push(googleStorage.uploadToGoogleStorage(file, roomGroupId, listUniqueId[index])));

        /**
         * Doing upload google storage
         */
        Promise.all(promises).then(uploadResponse => {
            const createRoomImagePromises = [];
            uploadResponse.forEach(data => {
                if (data.url) {
                    let createData: RoomImage = new RoomImage();
                    createData.imageUrl = data.url;
                    createData.roomGroupId = roomGroupId;
                    createRoomImagePromises.push(RoomImage.repo.save(createData));
                }
            });

            /**
             * Run all command & send to client
             */
            Promise.all(createRoomImagePromises).then(response => {
                res.status(200).send(response);
            });
        }).catch(error => {
            console.log(error);
            res.status(404).send(error);
        });
    };

    /**
     * Create or update multiple room images one time
     * Request data from client: {roomGroupId, urls}
     * @param req
     * @param res
     * @param next
     */
    static createRoomImage: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const {data, roomGroupId} = req.body || {};
        if (!data || !Array.isArray(data)) next(new HTTP400Error('Data is not valid'));
        if (!roomGroupId) next(new HTTP400Error('Room group id is not valid'));

        /**
         * Check validate data room amenities from client
         */
        let errors = [];
        for (let i = 0; i < data.length; i++) errors[i] = await validateByModel(RoomImage, data[i]);
        console.debug(errors);

        /**
         * Check multiple room amenities, do not insert if only one data error
         */
        if (errors.every(error => !!error)) next(new HTTP400Error(JSON.stringify(errors)));
        else {
            let promise = [];
            /**
             * Check record: Create new if not exists in DB & update if exists
             */
            for (let i = 0; i < data.length; i++) {
                const {imageId, imageUrl} = data[i];
                let roomImage = await RoomImage.repo.findOne(imageId);
                if (roomImage) {
                    roomImage.imageUrl = imageUrl;
                    promise.push(RoomImage.repo.save(roomImage));
                } else {
                    let createData: RoomImage = new RoomImage();
                    createData.imageUrl = imageUrl;
                    createData.roomGroupId = roomGroupId;
                    promise.push(RoomImage.repo.save(createData));
                }
            }

            /**
             * Run all command & send to client
             */
            Promise.all(promise).then(response => {
                res.status(200).send(response);
            });
        }
    };

    static deleteRoomImage: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const roomImageId = req.params['roomImageId'];
        const buildingId = req.params['buildingId'];
        const userId = req['currentUserId'];

        const building = await Building.repo.findOne(buildingId);

        if (building.hostId !== Number(userId)) next(new HTTP401Error('You are not authorized to perform this action.'));
        else if (!roomImageId) next(new HTTP400Error('Invalid room image id !'));
        else {
            const successResponse = await RoomImage.repo.delete(roomImageId);
            if (successResponse.affected != 0) res.status(200).send({result: 'Delete room image successfully !'});
            else next(new HTTP400Error('Room image not found'));
        }
    };
}
