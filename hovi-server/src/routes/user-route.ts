import UserFunction from "../functions/user-function";

export default [
    {
        path: "/user/",
        method: "get",
        authentication: true,
        handler: UserFunction.getUsers
    },
    {
        path: "/user/:userId",
        method: "get",
        handler: UserFunction.getUser
    },
    {
        path: "/user/show/:userId",
        method: "get",
        handler: UserFunction.getUserDetail
    },
    {
        path: "/user/",
        method: "post",
        authentication: true,
        handler: UserFunction.createUser
    },
    {
        path: "/user/:userId",
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
