import {Request, Response, NextFunction} from 'express';
import {HTTP401Error} from '../utils/httpErrors';

const Authentication = (request: Request, response: Response, next: NextFunction) => {
    const {auth} = request.query;

    if (auth === 'ok') {
        next();
    } else throw new HTTP401Error('Not authentication');
};

export default Authentication;
