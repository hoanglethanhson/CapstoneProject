import { Request, Response, NextFunction, Handler } from 'express';
import * as bcrypt from 'bcryptjs';
import { validateByModel } from '../utils';
import FirebaseApp from '../utils/firebaseApp';
import { HTTP400Error, HTTP409Error } from '../utils/httpErrors';
import { User } from '../models/user';
import {ConstantValues} from "../utils/constant-values";

export default class AuthFunction {

  static signIn: Handler = async (req: Request, res: Response, next: NextFunction) => {
    const { phone, password } = req.body;
    console.debug(phone, password);

    const existUser = await User.repo.findOne({ phoneNumber: phone });

    if (!existUser) next(new HTTP400Error({ error: 'Invalid phone number or password!' }));
    else if (!existUser.checkIfUnencryptedPasswordIsValid(password))
      next(new HTTP400Error({ error: 'Invalid phone number or password!' }));
    else {
      if (existUser.phoneToken) {
        res.status(200).send({
          verifyId: existUser.phoneToken,
        });
      } else {
        let claims = existUser.roleAdmin === 'admin' ? { admin: true } : {};
        FirebaseApp.auth().createCustomToken(String(existUser.id), claims)
          .then(function(customToken) {
            console.log(customToken);
            // Send token back to client
            res.status(200).send({
              firstName: existUser.firstName,
              lastName: existUser.lastName,
              phoneNumber: existUser.phoneNumber,
              accessToken: customToken,
            });
          })
          .catch(function(error) {
            console.debug(error);
            next(new HTTP400Error(error));
          });
      }
    }
  };

  static createUser: Handler = async (req: Request, res: Response, next: NextFunction) => {
    const body = req.body || {};

    body['email'] = ConstantValues.DEFAULT_EMAIL;
    body['address'] = ConstantValues.DEFAULT_ADDRESS;
    body['facebookId'] = ConstantValues.DEFAULT_FACEBOOK_ID;
    body['googleId'] = ConstantValues.DEFAULT_GOOGLE_ID;

    const error = await validateByModel(User, body);
    console.log(body);
    if (error) next(error);
    else {
      const checkPhoneNumber = await User.repo.findOne({ phoneNumber: body['phoneNumber'] });
      if (checkPhoneNumber) next(new HTTP409Error({
        phoneNumber: 'Phone number already exists',
      }));

      else {
        body['password'] = bcrypt.hashSync(body['password'], 8);
        const newUser = await User.repo.save(body);
        const successResponse = await User.repo.findOne({ id: newUser.id });
        successResponse['password'] = '';
        console.log(successResponse);
        res.status(200).send(successResponse);
      }
    }
  };

  static verifyPhoneNumber: Handler = async (req: Request, res: Response, next: NextFunction) => {
    const body = req.body || {};

    if (!body['phone']) next(new HTTP400Error({
      phone: 'Phone number not be empty',
    }));

    if (!body['phoneToken']) next(new HTTP400Error({
      phoneToken: 'Verify id phone number not be empty',
    }));

    const results = await User.repo.verifyPhoneNumber(body['phone'], body['phoneToken']);
    res.status(200).send(results);
  };

}
