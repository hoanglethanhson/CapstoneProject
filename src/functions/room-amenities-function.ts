import {Request, Response, NextFunction, Handler} from 'express';
import {validateByModel} from '../utils';
import {HTTP400Error} from '../utils/httpErrors';
import {RoomAmenities} from '../models/room-amenities';

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

    /**
     * Create or update multiple roomAmenities one time
     * Request data from client: {data, roomGroupId}
     * @param req
     * @param res
     * @param next
     */
    static createRoomAmenities: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const {data, roomGroupId} = req.body || {};
        if (!data || !Array.isArray(data)) next(new HTTP400Error('Data is not valid'));
        if (!roomGroupId) next(new HTTP400Error('Room group id is not valid'));

        /**
         * Check validate data room amenities from client
         */
        let errors = [];
        for (let i = 0; i < data.length; i++) errors[i] = await validateByModel(RoomAmenities, data[i]);
        console.debug(errors);

        /**
         * Check multiple room amenities, do not insert if only one data error
         */
        if (errors.every(error => !!error)) next(new HTTP400Error(JSON.stringify(errors)));
        else {
            let promise = [];
            /**
             * Check record: Create new if not exists in DB
             */
            for (let i = 0; i < data.length; i++) {
                const record = await RoomAmenities.repo.getOneRecord(roomGroupId, data[i]);
                if (!record) {
                    let createData: RoomAmenities = new RoomAmenities();
                    createData.amenitiesId = data[i];
                    createData.roomGroupId = roomGroupId;
                    promise.push(RoomAmenities.repo.save(createData));
                }
            }

            /**
             * Get all data room amenities by roomGroupId & format get only amenitiesId to array
             */
            const roomAmenities = await RoomAmenities.repo.getAmenitiesDetailRoomGroup(roomGroupId);
            const formatExistRoomAmenities = roomAmenities.map(val => val.amenities_id);

            /**
             * Filter to get array amenities id will delete
             */
            const deleteRoomAmenities = formatExistRoomAmenities.filter((obj) => !data.includes(obj));

            console.debug(formatExistRoomAmenities);
            console.debug(deleteRoomAmenities);

            /**
             * Delete room amenities in DB
             */
            for (let i = 0; i < deleteRoomAmenities.length; i++)
                promise.push(RoomAmenities.repo.deleteOneRecord(roomGroupId, deleteRoomAmenities[i]));

            /**
             * Run all command & send to client
             */
            Promise.all(promise).then(data => {
                res.status(200).send(data);
            }).catch(error => {
                console.log(error);
                next(new HTTP400Error(error));
            });
        }
    };

    static updateRoomAmenities: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const {data} = req.body || {};
        const roomGroupId = req.params['roomGroupId'];

        if (!data || !Array.isArray(data)) next(new HTTP400Error('Data is not valid'));
        if (!roomGroupId || roomGroupId === 'undefined') next(new HTTP400Error('Room group id is not valid'));

        let promise = [];
        /**
         * Check record: Create new if not exists in DB
         */
        for (let i = 0; i < data.length; i++) {
            const record = await RoomAmenities.repo.getOneRecord(roomGroupId, data[i]);
            if (!record) {
                let createData: RoomAmenities = new RoomAmenities();
                createData.amenitiesId = data[i];
                // @ts-ignore
                createData.roomGroupId = Number(roomGroupId);
                promise.push(RoomAmenities.repo.save(createData));
            }
        }

        /**
         * Get all data room amenities by roomGroupId & format get only amenitiesId to array
         */
        const roomAmenities = await RoomAmenities.repo.getAmenitiesDetailRoomGroup(roomGroupId);
        const formatExistRoomAmenities = roomAmenities.map(val => val.amenities_id);

        /**
         * Filter to get array amenities id will delete
         */
        const deleteRoomAmenities = formatExistRoomAmenities.filter((obj) => !data.includes(obj));

        console.debug(formatExistRoomAmenities);
        console.debug(deleteRoomAmenities);

        /**
         * Delete room amenities in DB
         */
        for (let i = 0; i < deleteRoomAmenities.length; i++)
            promise.push(RoomAmenities.repo.deleteOneRecord(roomGroupId, deleteRoomAmenities[i]));

        /**
         * Run all command & send to client
         */
        Promise.all(promise).then(data => {
            res.status(200).send(data);
        }).catch(error => {
            console.log(error);
            next(new HTTP400Error(error));
        });
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
