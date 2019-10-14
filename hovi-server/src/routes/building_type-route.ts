import roomTypeFunction from "../functions/building_type-function";

export default [
    {
        path: "/buildingType/",
        method: "get",
        authentication: false,
        handler: roomTypeFunction.getRoomTypes
    },
    {
        path: "/buildingType/:buildingTypeId",
        method: "get",
        authentication: false,
        handler: roomTypeFunction.getRoomType
    },
    {
        path: "/buildingType/",
        method: "post",
        authentication: false,
        handler: roomTypeFunction.createRoomType
    },
    {
        path: "/buildingType/:buildingTypeId",
        method: "put",
        authentication: false,
        handler: roomTypeFunction.updateRoomType
    },
    {
        path: "/buildingType/:buildingTypeId",
        method: "delete",
        authentication: false,
        handler: roomTypeFunction.deleteRoomType
    },
];
