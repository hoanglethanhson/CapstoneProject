import buildingServiceFunction from '../functions/building_service-function';

export default [
  {
    path: '/buildingService/multiple',
    method: 'post',
    authentication: false,
    handler: buildingServiceFunction.createMultipleBuildingService,
  },
  {
    path: '/buildingService/',
    method: 'get',
    authentication: false,
    handler: buildingServiceFunction.getBuildingServices,
  },
  {
    path: '/buildingService/:buildingId',
    method: 'get',
    authentication: false,
    handler: buildingServiceFunction.getBuildingService,
  },
  {
    path: '/buildingService/',
    method: 'post',
    authentication: false,
    handler: buildingServiceFunction.createBuildingService,
  },
  {
    path: '/buildingService/:buildingId/:serviceId',
    method: 'put',
    authentication: false,
    handler: buildingServiceFunction.updateBuildingService,
  },
  {
    path: '/buildingService/:buildingId/:serviceId',
    method: 'delete',
    authentication: false,
    handler: buildingServiceFunction.deleteBuildingService,
  },
];
