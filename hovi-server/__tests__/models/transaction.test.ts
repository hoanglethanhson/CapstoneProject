import {QueryFailedError} from 'typeorm';
import {DatabaseManager} from '../../src/models';
import {Transaction} from '../../src/models/transaction';
import {User} from "../../src/models/user";
import {Room} from "../../src/models/room";
import {Building} from "../../src/models/building";

describe('[model] transaction', () => {
    let user1 = new User();
    let room1 = new Room();
    beforeAll(async () => {
        await DatabaseManager.init();
    });

    afterAll(async () => {
        await DatabaseManager.close();
    });

    let transaction1: Transaction;
    beforeEach(async () => {
        await DatabaseManager.clearDataTransactionTest();
        transaction1 = new Transaction();
        transaction1.transactionId = 1;
        transaction1.userId = 1;
        transaction1.roomId = 1;
        transaction1 = await Transaction.repo.save(transaction1);
    });



    it('should return null if transaction is not found', async () => {
        const result = await Transaction.repo.findOne(1000);
        expect(result).toBeUndefined();
    });


    it('should return false if user id is not found', async () => {
        const result = await Transaction.repo.findOne({userId: 1000});
        expect(result).toBeFalsy();
    });

    it('should return false if room id is not found', async () => {
        const result = await Transaction.repo.findOne({roomId: 1000});
        expect(result).toBeFalsy();
    });

    it('should return right object after it was inserted', async () => {
        const duplicatedTransaction = new Transaction();
        duplicatedTransaction.userId = 1;
        duplicatedTransaction.roomId = 1;
        duplicatedTransaction.transactionId = 100;

        await Transaction.repo.save(duplicatedTransaction);

        const result = await Transaction.repo.find({transactionId: duplicatedTransaction.transactionId});
        expect(result).toBeTruthy();
    });

    it('should return right object after it was updated', async () => {
        const duplicatedTransaction = new Transaction();
        duplicatedTransaction.transactionId = 100;
        duplicatedTransaction.userId = 1;
        duplicatedTransaction.roomId = 1;

        await Transaction.repo.save(duplicatedTransaction);

        let updateTransaction = duplicatedTransaction;
        updateTransaction.transactionStatus = 2;
        await Transaction.repo.updateById(duplicatedTransaction.transactionId, updateTransaction);

        const result = await Transaction.repo.findOne({transactionId: duplicatedTransaction.transactionId});
        expect(result.transactionStatus).toBe(updateTransaction.transactionStatus);
    });

    it('should return null object after it was deleted', async () => {
        const duplicatedTransaction = new Transaction();
        duplicatedTransaction.transactionId = 100;
        duplicatedTransaction.userId = 1;
        duplicatedTransaction.roomId = 1;

        await Transaction.repo.save(duplicatedTransaction);
        await Transaction.repo.delete(duplicatedTransaction.transactionId);

        const result = await Building.repo.findOne({id: duplicatedTransaction.transactionId});
        expect(result).toBeUndefined();
    });

});
