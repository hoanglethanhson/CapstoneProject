import roomFunction from "../functions/room-function";

export default [
    {
        path: "/room/",
        method: "get",
        authentication: false,
        handler: roomFunction.getRooms
    },
    {
        path: "/room/:roomId",
        method: "get",
        authentication: false,
        handler: roomFunction.getRoom
    },
    {
        path: "/room/",
        method: "post",
        authentication: false,
        handler: roomFunction.createRoom
    },
    {
        path: "/room/:roomId",
        method: "put",
        authentication: false,
        handler: roomFunction.updateRoom
    },
    {
        path: "/room/:roomId",
        method: "delete",
        authentication: false,
        handler: roomFunction.deleteRoom
    },
];
