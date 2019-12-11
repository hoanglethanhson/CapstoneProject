import savedRoomFunction from "../functions/saved-room-function";

export default [
    {
        path: "/saved-rooms/",
        method: "get",
        authentication: true,
        handler: savedRoomFunction.getSavedRoom
    },
    {
        path: "/saved-rooms/",
        method: "post",
        authentication: true,
        handler: savedRoomFunction.saveRoom
    },
    {
        path: "/saved-rooms/:roomGroupId",
        method: "delete",
        authentication: true,
        handler: savedRoomFunction.deleteRoom
    },
];
