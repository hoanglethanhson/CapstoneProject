import {DatabaseManager} from './models';
import {applyMiddleware, applyRoutes} from './utils';
import routes from './routes';
import middleware from './middleware';
import errorHandlers from './middleware/errorHandlers';

process.on('uncaughtException', e => {
    console.log(e);
    process.exit(1);
});
process.on('unhandledRejection', e => {
    console.log(e);
    process.exit(1);
});

export default async () => {
    await DatabaseManager.init();
    const router = require('express')();
    applyMiddleware(middleware, router);
    applyRoutes(routes, router);
    applyMiddleware(errorHandlers, router);
    return router;
};
