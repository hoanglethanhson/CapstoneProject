import esFunction from '../functions/es-function';

export default [
    {
        path: '/createRoomES/:buildingId',
        method: 'post',
        authentication: true,
        handler: esFunction.createRoomES,
    },
];
