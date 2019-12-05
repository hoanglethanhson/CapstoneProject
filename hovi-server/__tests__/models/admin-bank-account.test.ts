import {DatabaseManager} from '../../src/models';
import {AdminBankAccount} from '../../src/models/admin-bank-account';
import {User} from "../../src/models/user";

describe('[model] bankAccount', () => {

    beforeAll(async () => {
        await DatabaseManager.init();
    });

    afterAll(async () => {
        await DatabaseManager.close();
    });

    let bankAccount1: AdminBankAccount;

    beforeEach(async () => {
        await DatabaseManager.clearData();
        await DatabaseManager.insertData();
        bankAccount1 = new AdminBankAccount();
        bankAccount1.accountId = 2;
        bankAccount1.bank = "A";

        //bankAccount1 = await AdminBankAccount.repo.save(bankAccount1);
    });


    it('should return null if bankAccount is not found', async () => {
        const result = await AdminBankAccount.repo.findOne(1000);
        expect(result).toBeUndefined();
    });

    it('should return true if bankAccount name is found', async () => {
        const result = await AdminBankAccount.repo.find({accountId: bankAccount1.accountId});
        expect(result).toBeTruthy();
    });

    it('should return false if bank name is not found', async () => {
        const result = await AdminBankAccount.repo.findOne({bank: "Do not set this to bankAccount name"});
        expect(result).toBeFalsy();
    });

    it('should return right object after it was inserted', async () => {
        const duplicatedAccount = new AdminBankAccount();
        duplicatedAccount.accountId = 3;

        await AdminBankAccount.repo.save(duplicatedAccount);

        const result = await AdminBankAccount.repo.find({accountId: duplicatedAccount.accountId});
        expect(result).toBeTruthy();
    });

    it('should return right object after it was updated', async () => {
        const duplicatedAccount = new AdminBankAccount();
        duplicatedAccount.accountId = 3;

        await AdminBankAccount.repo.save(duplicatedAccount);

        let updateBuilding = duplicatedAccount;
        updateBuilding.bank = 'update name';
        await AdminBankAccount.repo.updateById(duplicatedAccount.accountId, updateBuilding);

        const result = await AdminBankAccount.repo.findOne({accountId: duplicatedAccount.accountId});
        expect(result.bank).toBe(updateBuilding.bank);
    });

    it('should return null object after it was deleted', async () => {
        const duplicatedAccount = new AdminBankAccount();
        duplicatedAccount.accountId = 3;

        await AdminBankAccount.repo.save(duplicatedAccount);
        await AdminBankAccount.repo.delete(duplicatedAccount.accountId);

        const result = await AdminBankAccount.repo.findOne({accountId: duplicatedAccount.accountId});
        expect(result).toBeUndefined();
    });

});
