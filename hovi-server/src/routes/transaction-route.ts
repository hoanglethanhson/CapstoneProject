import TransactionFunction from "../functions/transaction-function";

export default [
    {
        path: "/transaction/",
        method: "get",
        authentication: true,
        handler: TransactionFunction.getTransactions
    },
    {
        path: "/transaction/:transactionId",
        method: "get",
        authentication: true,
        handler: TransactionFunction.getTransaction
    },
    {
        path: "/transaction/:roomId",
        method: "post",
        authentication: false,
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
    {
        path: "/transactionGen/:transactionId",
        method: "get",
        authentication: true,
        handler: TransactionFunction.generateTransferContent
    },
];
