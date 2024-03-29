import buildingFunction from '../functions/building-function';

export default [
    {
        path: '/building/',
        method: 'get',
        handler: buildingFunction.getBuildings,
    },
    {
        path: '/createRoomES/:buildingId',
        method: 'post',
        authentication: true,
        handler: buildingFunction.createRoomES,
    },
    {
        path: '/building/:buildingTypeId',
        method: 'get',
        authentication: true,
        handler: buildingFunction.getBuilding,
    },
    {
        path: '/buildingKhuTro/',
        method: 'get',
        authentication: true,
        handler: buildingFunction.getHostBuildings,
    },
    {
        path: '/building/',
        method: 'post',
        authentication: true,
        handler: buildingFunction.createBuilding,
    },
    {
        path: '/building/:buildingId',
        method: 'put',
        authentication: true,
        handler: buildingFunction.updateBuilding,
    },
    {
        path: '/building-by-id/:buildingId',
        method: 'get',
        authentication: true,
        handler: buildingFunction.getBuildingInformationById,
    },
];
