import buildingServiceFunction from "../functions/building_service-function";
import multiBuildingServiceFunction from "../functions/building_service-multiple_function"

export default [
    {
        path: "/buildingService/",
        method: "get",
        authentication: false,
        handler: buildingServiceFunction.getBuildingServices
    },
    {
        path: "/buildingService/:buildingId",
        method: "get",
        authentication: false,
        handler: buildingServiceFunction.getBuildingService
    },
    {
        path: "/buildingService/",
        method: "post",
        authentication: false,
        handler: buildingServiceFunction.createBuildingService
    },
    {
        path: "/multiBuildingService/",
        method: "post",
        authentication: false,
        handler: multiBuildingServiceFunction.createBuildingServices
    },
    {
        path: "/buildingService/:buildingId/:serviceId",
        method: "put",
        authentication: false,
        handler: buildingServiceFunction.updateBuildingService
    },
    {
        path: "/buildingService/:buildingId/:serviceId",
        method: "delete",
        authentication: false,
        handler: buildingServiceFunction.deleteBuildingService
    },
];
