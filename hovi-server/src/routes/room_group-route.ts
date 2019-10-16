import roomGroupFunction from "../functions/room_group-function";

export default [
    {
        path: "/roomGroup/",
        method: "get",
        authentication: false,
        handler: roomGroupFunction.getRoomGroups
    },
    {
        path: "/roomGroup/:roomGroupId",
        method: "get",
        authentication: false,
        handler: roomGroupFunction.getRoomGroup
    },
    {
        path: "/roomGroupDetail/:roomGroupId",
        method: "get",
        authentication: false,
        handler: roomGroupFunction.getRoomGroupDetail
    },
    {
        path: "/roomGroup/",
        method: "post",
        authentication: false,
        handler: roomGroupFunction.createRoomGroup
    },
    {
        path: "/roomGroup/:roomGroupId",
        method: "put",
        authentication: false,
        handler: roomGroupFunction.updateRoomGroup
    },
    {
        path: "/roomGroup/:roomGroupId",
        method: "delete",
        authentication: false,
        handler: roomGroupFunction.deleteRoomGroup
    },
];
