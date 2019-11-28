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
];
