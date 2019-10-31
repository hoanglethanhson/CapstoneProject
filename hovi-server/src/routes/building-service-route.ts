import buildingServiceFunction from '../functions/building-service-function';

export default [
  {
    path: '/buildingService/multiple',
    method: 'post',
    handler: buildingServiceFunction.createMultipleBuildingService,
  },
  {
    path: '/buildingService/',
    method: 'get',
    handler: buildingServiceFunction.getBuildingServices,
  },
  {
    path: '/buildingService/:buildingId',
    method: 'get',
    handler: buildingServiceFunction.getBuildingService,
  },
  {
    path: '/buildingService/',
    method: 'post',
    authentication: true,
    handler: buildingServiceFunction.createBuildingService,
  },
  {
    path: '/buildingService/:buildingId/:serviceId',
    method: 'put',
    authentication: true,
    handler: buildingServiceFunction.updateBuildingService,
  },
  {
    path: '/buildingService/:buildingId/:serviceId',
    method: 'delete',
    authentication: true,
    handler: buildingServiceFunction.deleteBuildingService,
  },
];
