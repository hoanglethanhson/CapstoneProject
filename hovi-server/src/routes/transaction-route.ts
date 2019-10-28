import TransactionFunction from "../functions/transaction-function";

export default [
    {
        path: "/transaction/",
        method: "get",
        authentication: false,
        handler: TransactionFunction.getTransactions
    },
    {
        path: "/transaction/:transactionId",
        method: "get",
        authentication: false,
        handler: TransactionFunction.getTransaction
    },
    {
        path: "/transaction/",
        method: "post",
        authentication: false,
        handler: TransactionFunction.createTransaction
    },
    {
        path: "/transaction/:transactionId",
        method: "put",
        authentication: false,
        handler: TransactionFunction.updateTransaction
    },
    {
        path: "/transaction/:transactionId",
        method: "delete",
        authentication: false,
        handler: TransactionFunction.deleteTransaction
    },
];
