import BankTransferHistoryFunction from "../functions/bank-transfer-history-function";

export default [
    {
        path: "/bankTransferHistory/",
        method: "get",
        handler: BankTransferHistoryFunction.getBankTransferHistories
    },
    {
        path: "/bankTransferHistory/:bankTransferHistoryId",
        method: "get",
        handler: BankTransferHistoryFunction.getBankTransferHistory
    },
    {
        path: "/bankTransferHistory/",
        method: "post",
        authentication: false,
        handler: BankTransferHistoryFunction.createBankTransferHistory
    },
    {
        path: "/bankTransferHistory/:bankTransferHistoryId",
        method: "put",
        authentication: true,
        handler: BankTransferHistoryFunction.updateBankTransferHistory
    },
    {
        path: "/bankTransferHistory/:bankTransferHistoryId",
        method: "delete",
        authentication: true,
        handler: BankTransferHistoryFunction.deleteBankTransferHistory
    },
];
