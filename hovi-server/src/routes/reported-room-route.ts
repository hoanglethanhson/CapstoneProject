import reportedRoomFunction from "../functions/reported-room-function";

export default [
    {
        path: "/reportedRoom/",
        authentication: false,
        method: "get",
        handler: reportedRoomFunction.getReportedRooms
    },
    {
        path: "/reportedRoom/:reportId",
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
        path: "/reportedRoom/:reportId",
        authentication: true,
        method: "put",
        handler: reportedRoomFunction.updateReportedRoom
    },
    {
        path: "/reportedRoom/:reportId",
        method: "delete",
        authentication: true,
        handler: reportedRoomFunction.deleteReportedRoom
    },
];
