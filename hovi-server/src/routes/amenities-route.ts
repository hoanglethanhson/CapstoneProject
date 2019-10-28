import amenitiesFunction from "../functions/amenities-function";

export default [
    {
        path: "/amenities/",
        method: "get",
        authentication: false,
        handler: amenitiesFunction.getAmenities
    },
    {
        path: "/amenities/:amenitiesId",
        method: "get",
        authentication: false,
        handler: amenitiesFunction.getAmenitiesOne
    },
    {
        path: "/amenities/",
        method: "post",
        authentication: false,
        handler: amenitiesFunction.createAmenities
    },
    {
        path: "/amenities/:amenitiesId",
        method: "put",
        authentication: false,
        handler: amenitiesFunction.updateAmenities
    },
    {
        path: "/amenities/:amenitiesId",
        method: "delete",
        authentication: false,
        handler: amenitiesFunction.deleteAmenities
    },
];
