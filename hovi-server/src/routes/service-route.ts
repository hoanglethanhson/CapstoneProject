import serviceFunction from "../functions/service-function";

export default [
    {
        path: "/service/",
        method: "get",
        authentication: true,
        handler: serviceFunction.getServices
    },
    {
        path: "/service/:serviceId",
        method: "get",
        handler: serviceFunction.getService
    },
    {
        path: "/service/",
        method: "post",
        authentication: true,
        handler: serviceFunction.createService
    },
    {
        path: "/service/:serviceId",
        method: "put",
        authentication: true,
        handler: serviceFunction.updateService
    },
    {
        path: "/service/:serviceId",
        method: "delete",
        authentication: true,
        handler: serviceFunction.deleteService
    },
];
