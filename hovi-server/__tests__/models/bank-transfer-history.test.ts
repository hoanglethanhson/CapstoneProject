import {QueryFailedError} from 'typeorm';
import {DatabaseManager} from '../../src/models';
import {BankTransferHistory} from '../../src/models/bank-transfer-history';

describe('[model] bankTransferHistory', () => {
    beforeAll(async () => {
        await DatabaseManager.init();
    });

    afterAll(async () => {
        await DatabaseManager.close();
    });

    let bankTransferHistory1: BankTransferHistory;
    beforeEach(async () => {
        await DatabaseManager.clearData();
        await DatabaseManager.insertData();
        bankTransferHistory1 = new BankTransferHistory();
        bankTransferHistory1.transferId = 1;
        bankTransferHistory1.transferCode = "1234"
        bankTransferHistory1 = await BankTransferHistory.repo.save(bankTransferHistory1);
    });

    it('should return null if bankTransferHistory is not found', async () => {
        const result = await BankTransferHistory.repo.findOne(1000);
        expect(result).toBeUndefined();
    });

    it('should return true if bankTransferHistory code is found', async () => {
        const result = await BankTransferHistory.repo.find({transferCode: bankTransferHistory1.transferCode});
        expect(result).toBeTruthy();
    });

    it('should return false if bankTransferHistory cdoe is not found', async () => {
        const result = await BankTransferHistory.repo.findOne({transferCode: "bla bla"});
        expect(result).toBeFalsy();
    });

    it('should return right object after it was inserted', async () => {
        const duplicatedBankTransferHistory = new BankTransferHistory();
        duplicatedBankTransferHistory.transferId = 1;

        await BankTransferHistory.repo.save(duplicatedBankTransferHistory);

        const result = await BankTransferHistory.repo.findOne(duplicatedBankTransferHistory.transferId);
        expect(result).toBeTruthy();
    });

    it('should return right object after it was updated', async () => {
        const duplicatedBankTransferHistory = new BankTransferHistory();
        duplicatedBankTransferHistory.transferId = 1;
        duplicatedBankTransferHistory.transferCode = "123";

        await BankTransferHistory.repo.save(duplicatedBankTransferHistory);

        let updateBankTransferHistory = duplicatedBankTransferHistory;
        updateBankTransferHistory.transferCode = '1234';
        await BankTransferHistory.repo.updateById(duplicatedBankTransferHistory.transferId, updateBankTransferHistory);

        const result = await BankTransferHistory.repo.find({transferCode: updateBankTransferHistory.transferCode});
        expect(result).toBeTruthy();
    });

    it('should return null object after it was deleted', async () => {
        const duplicatedBankTransferHistory = new BankTransferHistory();
        duplicatedBankTransferHistory.transferId = 1;
        duplicatedBankTransferHistory.transferCode = "123";

        await BankTransferHistory.repo.save(duplicatedBankTransferHistory);

        await BankTransferHistory.repo.delete(duplicatedBankTransferHistory.transferId);

        const result = await BankTransferHistory.repo.findOne(duplicatedBankTransferHistory.transferId);
        expect(result).toBeUndefined();
    });
});
