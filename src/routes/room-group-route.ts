import roomGroupFunction from "../functions/room-group-function";

export default [
    {
        path: "/roomGroup/",
        method: "get",
        handler: roomGroupFunction.getRoomGroups
    },
    // {
    //     path: "/roomGroup/:roomGroupId",
    //     method: "get",
    //     authentication: false,
    //     handler: roomGroupFunction.getRoomGroup
    // },
    {
        path: "/roomGroup/:buildingId",
        method: "get",
        handler: roomGroupFunction.getRoomGroupByBuildingId
    },
    {
        path: "/roomGroupDetail/:roomGroupId",
        method: "get",
        handler: roomGroupFunction.getRoomGroupDetail
    },
    {
        path: "/getCanComment/:roomGroupId",
        method: "get",
        authentication: true,
        handler: roomGroupFunction.getCanComment
    },
    {
        path: "/transaction/:transactionId",
        method: "get",
        authentication: true,
        handler: roomGroupFunction.getRoomGroupTransactionDetail
    },
    {
        path: "/roomGroup/",
        method: "post",
        authentication: true,
        handler: roomGroupFunction.createRoomGroup
    },
    {
        path: "/roomGroup/:roomGroupId",
        method: "put",
        authentication: true,
        handler: roomGroupFunction.updateRoomGroup
    },
    {
        path: "/roomGroup/:roomGroupId",
        method: "delete",
        authentication: true,
        handler: roomGroupFunction.deleteRoomGroup
    },
];
