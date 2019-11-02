import UserFunction from "../functions/user-function";

export default [
    {
        path: "/user/",
        method: "get",
        authentication: true,
        handler: UserFunction.getUsers
    },
    {
        path: "/userOne/",
        method: "get",
        authentication: true,
        handler: UserFunction.getUser
    },
    {
        path: "/userShow/",
        method: "get",
        authentication: true,
        handler: UserFunction.getUserDetail
    },
    {
        path: "/user/",
        method: "post",
        authentication: true,
        handler: UserFunction.createUser
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
];
