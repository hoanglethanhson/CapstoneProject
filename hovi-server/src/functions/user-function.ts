import { Request, Response, NextFunction, Handler } from 'express';
import * as bcrypt from 'bcryptjs';
import { validateByModel } from '../utils';
import { HTTP400Error } from '../utils/httpErrors';
import { User } from '../models/user';

export default class UserFunction {
  static getUsers: Handler = async (req: Request, res: Response, next: NextFunction) => {
    const users = await User.repo.find();
    if (users.length != 0) res.status(200).send(users);
    else next(new HTTP400Error('0 record.'));
  };

  static getUser: Handler = async (req: Request, res: Response, next: NextFunction) => {
    const userId = req['currentUserId'];
    const user = await User.repo.findOne(userId);
    //console.log(userId)

    if (user) res.status(200).send(user);
    else next(new HTTP400Error('userId not found.'));
  };

  static getUserDetail: Handler = async (req: Request, res: Response, next: NextFunction) => {
    const userId = req['currentUserId'];
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

  static createUser: Handler = async (req: Request, res: Response, next: NextFunction) => {
    const body = req.body || {};

    if (!body['email']) body['email'] = 'example@homehouse.vn';

    const error = await validateByModel(User, body);
    if (error) next(error);
    else {
      const checkUsername = await User.repo.findOne({ phoneNumber: body['phone'] });
      if (checkUsername) next(new HTTP400Error('Phone number already exists'));

      else {
        body['password'] = bcrypt.hashSync(body['password'], 8);
        const newUser = await User.repo.save(body);
        const successResponse = await User.repo.findOne({ id: newUser.id });
        successResponse['password'] = '';
        res.status(200).send(successResponse);
      }
    }
  };

  static changePassword: Handler = async (req: Request, res: Response, next: NextFunction) => {
    const body = req.body || {};
    const userId = req['currentUserId'];
    const oldPassword = body.oldPassword;
    const user = await User.repo.findOne(userId);
    if (!user.checkIfUnencryptedPasswordIsValid(oldPassword)) {
      next(new HTTP400Error('Wrong current password!'));
    } else {
      const userUpdate = user;
      userUpdate.password = body.newPassword;
      const successResponse = await User.repo.updateById(userId, userUpdate);
      if (successResponse) res.status(200).send(successResponse.id);
      else next(new HTTP400Error('update password failed.'));
    }
  };

  static updateUser: Handler = async (req: Request, res: Response, next: NextFunction) => {
    const body = req.body || {};
    const userId = req['currentUserId'];
    const successResponse = await User.repo.updateById(userId, body);

    if (successResponse) res.status(200).send(successResponse);
    else next(new HTTP400Error('userId not found'));
  };

  static deleteUser: Handler = async (req: Request, res: Response, next: NextFunction) => {
    const userId = req['currentUserId'];
    const successResponse = await User.repo.delete(userId);

    if (successResponse.affected != 0) res.status(200).send('Delete user successfully !');
    else next(new HTTP400Error('userId not found'));
  };
}
