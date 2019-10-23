import { NextFunction, Request, Response } from 'express';
import FirebaseAdmin from '../utils/firebaseApp';
import { HTTP401Error } from '../utils/httpErrors';

const Authentication = (request: Request, response: Response, next: NextFunction) => {
  let accessTokenFromClient = request.headers.authorization;
  if (accessTokenFromClient) {
    FirebaseAdmin.auth().verifyIdToken(accessTokenFromClient)
      .then(function(decodedToken) {
        request['currentUserId'] = decodedToken.uid;
        next();
      }).catch(function(error) {
      if (error.code == 'auth/id-token-revoked') {
        // Token has been revoked. Inform the user to reauthenticate or signOut() the user.
        next(new HTTP401Error(error));
      } else {
        // Token is invalid.
      }
      console.debug(error);
    });
  } else {
    //Fail if token not present in header.
    console.debug('Missing access token');
    next(new HTTP401Error());
  }
};

export default Authentication;
