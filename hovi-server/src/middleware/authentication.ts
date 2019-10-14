import { NextFunction, Request, Response } from 'express';
import FirebaseAdmin from '../utils/firebaseApp';
import { HTTP401Error } from '../utils/httpErrors';

const Authentication = (request: Request, response: Response, next: NextFunction) => {
    let accessTokenFromClient = request.headers.authorization;
    if (accessTokenFromClient) {

        console.debug(accessTokenFromClient);
        FirebaseAdmin.auth().verifyIdToken(accessTokenFromClient)
          .then(function(decodedToken) {
              console.debug(decodedToken);
              request['currentUserId'] = decodedToken.uid;
              next();
          }).catch(function(error) {
            console.debug(error);
            next(new HTTP401Error(error));
        });
    } else {
        //Fail if token not present in header.
        console.debug('Missing access token');
        next(new HTTP401Error());
    }
};

export default Authentication;
