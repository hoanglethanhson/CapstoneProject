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

    static verifyPhoneNumber: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};

        if (!body['phoneNumber']) next(new HTTP400Error('Phone number not be empty'));

        const user = await User.repo.findOne({phoneNumber: body['phoneNumber']});
        if (!user) next(new HTTP409Error('Phone number not exists'));
        else {
            user.isPhoneNumberVerified = true;
            await User.repo.save(user);
            res.status(200).send('ok');
        }
    };

    static sendResetPasswordEmail: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const {email} = req.body || {};
        FirebaseAuthRequest({
            method: 'post',
            path: 'sendOobCode',
            body: {email, requestType: 'PASSWORD_RESET'}
        }, (error, response, body) => {
            if (error) next(new HTTP400Error('Error send reset password !'));
            else res.status(200).send(body);
        });
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

    static getIdToken = async (phone, done) => {
        const existUser = await User.repo.findOne({phoneNumber: phone});
        if (!existUser) done({error: 'User not exists'});

        let claims = existUser.roleAdmin === 'admin' ? {admin: true} : {};
        FirebaseApp.auth().createCustomToken(String(existUser.id), claims)
            .then(token => {
                FirebaseAuthRequest({
                    method: 'post',
                    path: 'signInWithCustomToken',
                    body: {token: token}
                }, (error, res, body) => {
                    if (error) return;
                    else done(body.idToken);
                });
            }).catch(function (error) {
            console.debug(error);
        });
    }
}
