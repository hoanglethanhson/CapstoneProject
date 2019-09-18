import express, {Request, Response, Router} from "express";
import request from "supertest";
import {applyMiddleware} from "../../src/utils";
import middleware from '../../src/middleware';
import errorHandlers from '../../src/middleware/errorHandlers';
import authentication from '../../src/middleware/authentication';

describe('auth routes', () => {
    let router: Router;

    beforeEach(() => {
        router = express();
        applyMiddleware(middleware, router);
        router.use(authentication);
        router.get('/test', (request: Request, response: Response) => {
            response.status(200).send('authorize ok');
        });
        applyMiddleware(errorHandlers, router);
    });

    it('should authorize successfully if user exists', async () => {
        const response = await request(router).get("/test?auth=ok");
        expect(response.status).toEqual(200);
    });

    it('should throw unauthorized error if user does not exist', async () => {
        const response = await request(router).get("/test");
        expect(response.status).toEqual(401);
    });

    it('test change', async () => {
        const response = await request(router).get("/test");
        expect(response.status).toEqual(401);
    });
});
