import roomTypeFunction from "../functions/room_type-function";

export default [
    {
        path: "/roomType/",
        method: "get",
        authentication: false,
        handler: roomTypeFunction.getRoomTypes
    },
    {
        path: "/roomType/:roomTypeId",
        method: "get",
        authentication: false,
        handler: roomTypeFunction.getRoomType
    },
    {
        path: "/roomType/",
        method: "post",
        authentication: false,
        handler: roomTypeFunction.createRoomType
    },
    {
        path: "/roomType/:roomTypeId",
        method: "put",
        authentication: false,
        handler: roomTypeFunction.updateRoomType
    },
    {
        path: "/roomType/:roomTypeId",
        method: "delete",
        authentication: false,
        handler: roomTypeFunction.deleteRoomType
    },
];
