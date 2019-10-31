import TransactionFunction from "../functions/transaction-function";

export default [
    {
        path: "/transaction/",
        method: "get",
        handler: TransactionFunction.getTransactions
    },
    {
        path: "/transaction/:transactionId",
        method: "get",
        handler: TransactionFunction.getTransaction
    },
    {
        path: "/transaction/",
        method: "post",
        authentication: true,
        handler: TransactionFunction.createTransaction
    },
    {
        path: "/transaction/:transactionId",
        method: "put",
        authentication: true,
        handler: TransactionFunction.updateTransaction
    },
    {
        path: "/transaction/:transactionId",
        method: "delete",
        authentication: true,
        handler: TransactionFunction.deleteTransaction
    },
];
