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
        authentication: true,
        handler: UserFunction.getUser
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
