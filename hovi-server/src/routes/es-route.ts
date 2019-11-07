import esFunction from '../functions/es-function';

export default [
  {
    path: '/esInit/',
    method: 'get',
    handler: esFunction.esInit,
  },
  {
    path: '/createRoomES/:buildingId',
    method: 'get',
    handler: esFunction.createRoomES,
  },
];
