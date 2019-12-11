import roomTypeFunction from "../functions/building-type-function";

export default [
    {
        path: "/buildingType/",
        method: "get",
        handler: roomTypeFunction.getRoomTypes
    },
    {
        path: "/buildingType/:buildingTypeId",
        method: "get",
        handler: roomTypeFunction.getRoomType
    },
    {
        path: "/buildingType/",
        method: "post",
        authentication: true,
        handler: roomTypeFunction.createRoomType
    },
    {
        path: "/buildingType/:buildingTypeId",
        method: "put",
        authentication: true,
        handler: roomTypeFunction.updateRoomType
    },
    {
        path: "/buildingType/:buildingTypeId",
        method: "delete",
        authentication: true,
        handler: roomTypeFunction.deleteRoomType
    },
];
