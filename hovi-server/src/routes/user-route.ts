import UserFunction from "../functions/user-function";

export default [
    {
        path: "/user/",
        method: "get",
        authentication: false,
        handler: UserFunction.getUsers
    },
    {
        path: "/user/:userId",
        method: "get",
        authentication: false,
        handler: UserFunction.getUser
    },
    {
        path: "/user/show/:userId",
        method: "get",
        authentication: false,
        handler: UserFunction.getUserDetail
    },
    {
        path: "/user/",
        method: "post",
        authentication: false,
        handler: UserFunction.createUser
    },
    {
        path: "/user/:userId",
        method: "put",
        authentication: false,
        handler: UserFunction.updateUser
    },
    {
        path: "/user/:userId",
        method: "delete",
        authentication: false,
        handler: UserFunction.deleteUser
    },
];
