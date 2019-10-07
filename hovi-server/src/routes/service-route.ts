import serviceFunction from "../functions/service-function";

export default [
    {
        path: "/service/",
        method: "get",
        authentication: false,
        handler: serviceFunction.getServices
    },
    {
        path: "/service/:serviceId",
        method: "get",
        authentication: false,
        handler: serviceFunction.getService
    },
    {
        path: "/service/",
        method: "post",
        authentication: false,
        handler: serviceFunction.createService
    },
    {
        path: "/service/:serviceId",
        method: "put",
        authentication: false,
        handler: serviceFunction.updateService
    },
    {
        path: "/service/:serviceId",
        method: "delete",
        authentication: false,
        handler: serviceFunction.deleteService
    },
];
