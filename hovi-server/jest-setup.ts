import 'reflect-metadata';

require('dotenv-flow').config({
  path: './config/env-files',
  node_env: process.env.NODE_ENV || 'test'
});

global.console.log = () => {};
global.console.error = () => {};
