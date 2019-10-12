import roomAmenitiesFunction from "../functions/room_amenities-function";

export default [
    {
        path: "/roomAmenities/",
        method: "get",
        authentication: false,
        handler: roomAmenitiesFunction.getRoomAmenitiesM
    },
    {
        path: "/roomAmenities/:roomGroupId",
        method: "get",
        authentication: false,
        handler: roomAmenitiesFunction.getRoomAmenities
    },
    {
        path: "/roomAmenities/",
        method: "post",
        authentication: false,
        handler: roomAmenitiesFunction.createRoomAmenities
    },
    {
        path: "/roomAmenities/:roomGroupId/:amenitiesId",
        method: "put",
        authentication: false,
        handler: roomAmenitiesFunction.updateRoomAmenities
    },
    {
        path: "/roomAmenities/:roomGroupId/:amenitiesId",
        method: "delete",
        authentication: false,
        handler: roomAmenitiesFunction.deleteRoomAmenities
    },
];
