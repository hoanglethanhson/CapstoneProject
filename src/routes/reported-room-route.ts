import reportedRoomFunction from "../functions/reported-room-function";

export default [
    {
        path: "/reportedRoom/",
        authentication: false,
        method: "get",
        handler: reportedRoomFunction.getReportedRooms
    },
    {
        path: "/reportedRoom/:reportedRoomId",
        authentication: false,
        method: "get",
        handler: reportedRoomFunction.getReportedRoom
    },
    {
        path: "/reportedRoom/",
        authentication: true,
        method: "post",
        handler: reportedRoomFunction.createReportedRoom
    },
    {
        path: "/reportedRoom/:reportedRoomId",
        authentication: true,
        method: "put",
        handler: reportedRoomFunction.updateReportedRoom
    },
    {
        path: "/reportedRoom/:reportedRoomId",
        method: "delete",
        authentication: true,
        handler: reportedRoomFunction.deleteReportedRoom
    },
];
