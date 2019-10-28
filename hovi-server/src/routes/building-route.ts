import buildingFunction from "../functions/building-function";

export default [
    {
        path: "/building/",
        method: "get",
        authentication: false,
        handler: buildingFunction.getBuildings
    },
    {
        path: "/building/:buildingId",
        method: "get",
        authentication: false,
        handler: buildingFunction.getBuilding
    },
    {
        path: "/building/",
        method: "post",
        authentication: false,
        handler: buildingFunction.createBuilding
    },
    {
        path: "/building/:buildingId",
        method: "put",
        authentication: false,
        handler: buildingFunction.updateBuilding
    },
    {
        path: "/building/:buildingId",
        method: "delete",
        authentication: false,
        handler: buildingFunction.deleteBuilding
    },
];
