import { Request, Response, NextFunction, Router } from 'express';
import HttpException from '../utils/HttpException';

function errorMiddleware(router: Router) {
  router.use((error: HttpException, request: Request, response: Response, next: NextFunction) => {
    const status = error.status || 500;
    const message = error.message || 'Something went wrong';
    response
      .status(status)
      .send({
        status,
        message,
      });
  });
}

export default [errorMiddleware];
