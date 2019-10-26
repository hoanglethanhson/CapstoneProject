import roomAmenitiesFunction from "../functions/room-amenities-function";

export default [
    {
        path: "/roomAmenities/",
        method: "get",
        handler: roomAmenitiesFunction.getRoomAmenitiesM
    },
    {
        path: "/roomAmenities/:roomGroupId",
        method: "get",
        handler: roomAmenitiesFunction.getRoomAmenities
    },
    {
        path: "/roomAmenities/",
        method: "post",
        authentication: true,
        handler: roomAmenitiesFunction.createRoomAmenities
    },
    {
        path: "/roomAmenities/:roomGroupId/:amenitiesId",
        method: "put",
        authentication: true,
        handler: roomAmenitiesFunction.updateRoomAmenities
    },
    {
        path: "/roomAmenities/:roomGroupId/:amenitiesId",
        method: "delete",
        authentication: true,
        handler: roomAmenitiesFunction.deleteRoomAmenities
    },
];
