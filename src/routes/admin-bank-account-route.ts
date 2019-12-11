import adminBankAccountFunction from "../functions/admin-bank-account-function";

export default [
    {
        path: "/adminBankAccount/",
        method: "get",
        handler: adminBankAccountFunction.getAdminBankAccounts
    },
    {
        path: "/adminBankAccount/:accountId",
        method: "get",
        handler: adminBankAccountFunction.getAdminBankAccount
    },
    {
        path: "/adminBankAccount/",
        method: "post",
        authentication: true,
        handler: adminBankAccountFunction.createAdminBankAccount
    },
    {
        path: "/adminBankAccount/:adminBankAccountId",
        method: "put",
        authentication: true,
        handler: adminBankAccountFunction.updateAdminBankAccount
    },
    {
        path: "/adminBankAccount/:adminBankAccountId",
        method: "delete",
        authentication: true,
        handler: adminBankAccountFunction.deleteAdminBankAccount
    },
];
