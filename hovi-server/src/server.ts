import 'reflect-metadata';

require('dotenv-flow').config({
  path: './config/env-files',
  node_env: process.env.NODE_ENV
});

import http from 'http';
import express from 'express';
import { DatabaseManager } from './models';
import { applyMiddleware, applyRoutes } from './utils';
import config from '../config';
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

const { PORT = 8000 } = config;
DatabaseManager.init().then(() => {
  console.info('TypeORM connecting successfully...');
  const router = express();
  applyMiddleware(middleware, router);
  applyRoutes(routes, router);
  applyMiddleware(errorHandlers, router);

  const server = http.createServer(router);
  server.listen(PORT, () =>
    console.log(`Server is running at port: ${PORT}`),
  );
}).catch(error => {
  console.error('TypeORM connection error: ');
  console.error(error);
  DatabaseManager.close().then(() => console.info('TypeORM connection close successfully.'));
});
