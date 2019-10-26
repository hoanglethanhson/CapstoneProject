import amenitiesFunction from "../functions/amenities-function";

export default [
    {
        path: "/amenities/",
        method: "get",
        handler: amenitiesFunction.getAmenities
    },
    {
        path: "/amenities/:amenitiesId",
        method: "get",
        handler: amenitiesFunction.getAmenitiesOne
    },
    {
        path: "/amenities/",
        method: "post",
        authentication: true,
        handler: amenitiesFunction.createAmenities
    },
    {
        path: "/amenities/:amenitiesId",
        method: "put",
        authentication: true,
        handler: amenitiesFunction.updateAmenities
    },
    {
        path: "/amenities/:amenitiesId",
        method: "delete",
        authentication: true,
        handler: amenitiesFunction.deleteAmenities
    },
];
