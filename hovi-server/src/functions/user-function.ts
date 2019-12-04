import {Request, Response, NextFunction, Handler} from 'express';
import GoogleStorage from '../utils/gcp';
import * as bcrypt from 'bcryptjs';
import {validateByModel} from '../utils';
import {HTTP400Error} from '../utils/httpErrors';
import {User} from '../models/user';
import FirebaseApp from '../utils/firebaseApp';
import config from "../../config";

const googleStorage = new GoogleStorage(config.BUCKET_NAME);

export default class UserFunction {
    static getAvatar: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const userId = req['currentUserId'];
        const user = await User.repo.findOne(userId);
        if (user) res.status(200).send({avatar: user.avatar});
        else next(new HTTP400Error('Error images.'));
    };

    static getUser: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const userId = req['currentUserId'];
        const user = await User.repo.findOne(userId);
        //console.log(userId)

        if (user) res.status(200).send(user);
        else next(new HTTP400Error('userId not found.'));
    };

    static getUserDetail: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const userId = req.params['id'];
        const user = await User.repo.getUserDetail(userId);

        if (user) res.status(200).send(user);
        else next(new HTTP400Error('userId not found.'));
    };

    static getUserSetting: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const userId = req['currentUserId'];
        const user = await User.repo.getUserSetting(userId);

        if (user) res.status(200).send(user);
        else next(new HTTP400Error('userId not found.'));
    };

    static updateUser: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const userId = req['currentUserId'];
        const successResponse = await User.repo.updateUserInformationById(userId, body);

        if (successResponse) {
            await FirebaseApp.auth().updateUser(userId, {
                displayName: `${successResponse.firstName},${successResponse.lastName}`,
            });

            res.status(200).send(successResponse);
        } else next(new HTTP400Error('userId not found'));
    };

    static updateUserImage: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const userId = req['currentUserId'];
        const {uniqueId, typeImage} = req.body;
        const file = req['file'];

        if (!file) next(new HTTP400Error('Images not found.'));
        else if (!uniqueId) next(new HTTP400Error('Unique id not found.'));
        else if (!typeImage) next(new HTTP400Error('Type image not found.'));
        else {
            const response = await googleStorage.uploadUserImage(file, typeImage, userId, uniqueId);
            await User.repo.updateUserImage(userId, typeImage, response['url']);
            if (typeImage === 'avatar') await FirebaseApp.auth().updateUser(userId, {
                photoURL: response['url']
            });

            res.status(200).send({message: 'Upload successfully'});
        }
    };

    static deleteUser: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const userId = req['currentUserId'];
        const successResponse = await User.repo.delete(userId);

        if (successResponse.affected != 0) res.status(200).send('Delete user successfully !');
        else next(new HTTP400Error('userId not found'));
    };
}
