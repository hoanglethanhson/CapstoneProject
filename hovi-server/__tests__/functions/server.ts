import http from 'http';
import express from 'express';
import {DatabaseManager} from '../../src/models';
import {applyMiddleware, applyRoutes} from '../../src/utils';
import config from '../../config';
import routes from '../../src/routes';
import middleware from '../../src/middleware';
import errorHandlers from '../../src/middleware/errorHandlers';

process.on('uncaughtException', e => {
    console.log(e);
    process.exit(1);
});
process.on('unhandledRejection', e => {
    console.log(e);
    process.exit(1);
});

const {PORT = 8000} = config;
export default async () => {
    await DatabaseManager.init();
    const router = express();
    applyMiddleware(middleware, router);
    applyRoutes(routes, router);
    applyMiddleware(errorHandlers, router);
    return router;
};
