import roomImageFunction from "../functions/room_image-function";

export default [
    {
        path: "/roomImage/",
        method: "get",
        authentication: false,
        handler: roomImageFunction.getRoomImages
    },
    {
        path: "/roomImage/:roomImageId",
        method: "get",
        authentication: false,
        handler: roomImageFunction.getRoomImage
    },
    {
        path: "/roomImage/",
        method: "post",
        authentication: false,
        handler: roomImageFunction.createRoomImage
    },
    {
        path: "/roomImage/:roomImageId",
        method: "put",
        authentication: false,
        handler: roomImageFunction.updateRoomImage
    },
    {
        path: "/roomImage/:roomImageId",
        method: "delete",
        authentication: false,
        handler: roomImageFunction.deleteRoomImage
    },
];
