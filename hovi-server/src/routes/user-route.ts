import UserFunction from "../functions/user-function";

export default [
    {
        path: "/user/avatar",
        method: "get",
        authentication: true,
        handler: UserFunction.getAvatar
    },
    {
        path: "/userOne/",
        method: "get",
        authentication: true,
        handler: UserFunction.getUser
    },
    {
        path: "/userShow/:id",
        method: "get",
        handler: UserFunction.getUserDetail
    },
    {
        path: "/userSetting/",
        method: "get",
        authentication: true,
        handler: UserFunction.getUserSetting
    },
    {
        path: "/user/",
        method: "put",
        authentication: true,
        handler: UserFunction.updateUser
    },
    {
        path: "/user/:userId",
        method: "delete",
        authentication: true,
        handler: UserFunction.deleteUser
    },
    {
        path: '/user/upload',
        method: 'post',
        authentication: true,
        uploadOptions: {
            type: 'photos',
            fileSize: 10 * 1024 * 1024,
            isMultiple: false,
        },
        handler: UserFunction.updateUserImage
    },
];
