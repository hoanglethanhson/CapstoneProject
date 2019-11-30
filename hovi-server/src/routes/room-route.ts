import roomFunction from "../functions/room-function";

export default [
    {
        path: "/room/",
        method: "get",
        handler: roomFunction.getRooms
    },
    {
        path: "/room/:roomId",
        method: "get",
        handler: roomFunction.getRoom
    },
    {
        path: "/management/getListRoom/:keySent",
        authentication: false,
        method: "get",
        handler: roomFunction.getManagementRooms
    },
    {
        path: "/room/",
        method: "post",
        authentication: true,
        handler: roomFunction.createRoom
    },
    {
        path: "/room/:roomId",
        method: "put",
        authentication: true,
        handler: roomFunction.updateRoom
    },
    {
        path: "/room/:roomId",
        method: "delete",
        authentication: true,
        handler: roomFunction.deleteRoom
    },
];
