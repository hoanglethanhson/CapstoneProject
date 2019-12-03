import {Handler, NextFunction, Request, Response} from 'express';
import * as bcrypt from 'bcryptjs';
import {validateByModel, FirebaseAuthRequest} from '../utils';
import FirebaseApp from '../utils/firebaseApp';
import {HTTP400Error, HTTP409Error, HTTP403Error, HTTP404Error} from '../utils/httpErrors';
import {User} from '../models/user';
import {ConstantValues} from "../utils/constant-values";

export default class AuthFunction {

    static signIn: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const {phone, password} = req.body;
        console.debug(phone, password);

        const existUser = await User.repo.findOne({phoneNumber: phone});

        if (!existUser) next(new HTTP404Error('Số điện thoại hoặc mật khẩu không đúng.'));
        else if (!existUser.checkIfUnencryptedPasswordIsValid(password))
            next(new HTTP404Error('Số điện thoại hoặc mật khẩu không đúng.'));
        else if (!existUser.isPhoneNumberVerified) {
            next(new HTTP403Error('Số điện thoại của bạn chưa được xác thực.'))
        } else {
            let claims = existUser.roleAdmin === 'admin' ? {admin: true} : {};
            FirebaseApp.auth().createCustomToken(String(existUser.id), claims)
                .then(function (accessToken) {
                    // Send token back to client
                    res.status(200).send({accessToken});
                }).catch(function (error) {
                console.debug(error);
                next(new HTTP400Error(error));
            });
        }
    };

    static createUser: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};

        body['roleAdmin'] = '';
        body['email'] = ConstantValues.DEFAULT_EMAIL;
        body['address'] = ConstantValues.DEFAULT_ADDRESS;
        body['avatar'] = ConstantValues.DEFAULT_AVATAR;

        const error = await validateByModel(User, body);
        if (error) next(error);
        else {
            const checkPhoneNumber = await User.repo.findOne({phoneNumber: body['phoneNumber']});
            if (checkPhoneNumber) next(new HTTP409Error('Phone number already exists'));
            else {
                body['password'] = bcrypt.hashSync(body['password'], 8);
                const newUser = await User.repo.save(body);
                const successResponse = await User.repo.findOne({id: newUser.id});
                successResponse['password'] = '';
                FirebaseApp.auth().createUser({
                    uid: String(successResponse.id),
                    email: successResponse.email,
                    emailVerified: false,
                    phoneNumber: successResponse.phoneNumber,
                    displayName: `${successResponse.firstName},${successResponse.lastName}`,
                    photoURL: successResponse.avatar,
                }).then(userRecord => {
                    res.status(200).send(userRecord.toJSON());
                }).catch(error => {
                    next(new HTTP400Error(error))
                });
            }
        }
    };

    static resetPassword: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const {oobCode, password} = req.body || {};
        FirebaseAuthRequest({
            method: 'post',
            path: 'resetPassword',
            body: {oobCode, requestType: 'PASSWORD_RESET'}
        }, async (error, response, body) => {
            if (error) next(new HTTP400Error('Error reset password !'));
            else {
                if (body.error) next(new HTTP400Error(body.error.message));
                else {
                    const existUser = await User.repo.findOne({email: body.email});
                    existUser.password = bcrypt.hashSync(password, 8);
                    await User.repo.save(existUser);
                    res.status(200).send({message: 'Reset password successfully !'})
                }
            }
        });
    };

    static changePassword: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const userId = req['currentUserId'];
        const oldPassword = body.oldPassword;
        const user = await User.repo.findOne(userId);
        if (!user.checkIfUnencryptedPasswordIsValid(oldPassword)) {
            next(new HTTP400Error('Wrong current password!'));
        } else {
            user.password = bcrypt.hashSync(body.newPassword, 8);
            await User.repo.save(user);
            res.status(200).send({message: 'Update password successfully !'});
        }
    };

    static verifyEmail: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const {oobCode} = req.body || {};
        FirebaseAuthRequest({
            method: 'post',
            path: 'update',
            body: {oobCode}
        }, async (error, response, body) => {
            if (error) next(new HTTP400Error('Error verify email !'));
            else {
                if (body.error) next(new HTTP400Error(body.error.message));
                else res.status(200).send({message: 'Verify email successfully !'});
            }
        });
    };

    static getIdToken = async (phone) => {
        const existUser = await User.repo.findOne({phoneNumber: phone});
        if (!existUser) return {error: 'User not exists'};
        const claims = existUser.roleAdmin === 'admin' ? {admin: true} : {};
        const token = await FirebaseApp.auth().createCustomToken(String(existUser.id), claims);
        return new Promise((resolve, reject) => {
            FirebaseAuthRequest({
                method: 'post',
                path: 'signInWithCustomToken',
                body: {token: token, returnSecureToken: true}
            }, (error, res, body) => {
                if (error) reject(error);
                else resolve(body.idToken);
            });
        });
    }
}
