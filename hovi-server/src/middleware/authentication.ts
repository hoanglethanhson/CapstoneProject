import { NextFunction, Request, Response } from 'express';
import FirebaseAdmin from '../utils/firebaseApp';
import { HTTP401Error } from '../utils/httpErrors';

const Authentication = (request: Request, response: Response, next: NextFunction) => {
  let accessTokenFromClient = request.headers.authorization;
  if (accessTokenFromClient) {
    console.log('ssc');
    FirebaseAdmin.auth().verifyIdToken(accessTokenFromClient)
      .then(function(decodedToken) {
        console.log(decodedToken.uid);
        request['currentUserId'] = decodedToken.uid;
        request['userAdmin'] = decodedToken.admin;
        next();
      }).catch(function(error) {
      console.debug(error);
      if (error.code == 'auth/id-token-revoked') {
        // Token has been revoked. Inform the user to reauthenticate or signOut() the user.
        next(new HTTP401Error(error));
      } else {
        // Token is invalid.
        next(new HTTP401Error(error));
      }
    });
  } else {
    //Fail if token not present in header.
    console.debug('Missing access token');
    next(new HTTP401Error());
  }
};

export default Authentication;
