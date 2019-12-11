import systemInformationFunction from "../functions/system-information-function";

export default [
    {
        path: "/systemInformation/",
        method: "get",
        handler: systemInformationFunction.getSystemInformations
    },
    {
        path: "/systemInformation/:infoId",
        method: "get",
        handler: systemInformationFunction.getSystemInformation
    },
    {
        path: "/systemInformation/",
        method: "post",
        authentication: true,
        handler: systemInformationFunction.createSystemInformation
    },
    {
        path: "/systemInformation/:infoId",
        method: "put",
        authentication: true,
        handler: systemInformationFunction.updateSystemInformation
    },
    {
        path: "/systemInformation/:infoId",
        method: "delete",
        authentication: true,
        handler: systemInformationFunction.deleteSystemInformation
    },
];
