import {Request, Response, NextFunction, Handler} from 'express';
import {validateByModel} from '../utils';
import {HTTP400Error} from '../utils/httpErrors';
import {SavedRoom} from '../models/saved-room';

export default class SavedRoomFunction {
    static getSavedRoom: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const userId = req['currentUserId'];
        const savedRooms = await SavedRoom.repo.find({userId});
        res.status(200).send(savedRooms);
    };

    static saveRoom: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const userId = req['currentUserId'];
        body.userId = userId;

        const error = await validateByModel(SavedRoom, body);

        if (error) next(error);
        else {
            const isExists = await SavedRoom.repo.getOneRecord(body['roomGroupId'], userId);
            if (isExists) next(new HTTP400Error('This room have already exists in save list'));
            else {
                const newSavedRoom = await SavedRoom.repo.save(body);
                const successResponse = await SavedRoom.repo.getOneRecord(newSavedRoom.roomGroupId, newSavedRoom.userId);
                res.status(200).send(successResponse);
            }
        }
    };

    static deleteRoom: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const {roomGroupId} = req.params;
        const userId = req['currentUserId'];

        if (!roomGroupId) next(new HTTP400Error('Room group id not found'));
        else {
            const successResponse = await SavedRoom.repo.deleteOneRecord(roomGroupId, userId);
            if (successResponse.affected != 0) res.status(200).send({
                message: 'Delete saved room successfully !'
            });
            else next(new HTTP400Error(successResponse));
        }
    }
}
