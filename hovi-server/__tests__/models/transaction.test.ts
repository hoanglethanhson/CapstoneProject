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
        user1.id = 1;
        room1.roomId = 1;
        user1 = await User.repo.save(user1);
        room1 = await Room.repo.save(room1);
    });

    afterAll(async () => {
        await DatabaseManager.close();
    });

    let transaction1: Transaction;
    beforeEach(async () => {
        await DatabaseManager.clearDataTransactionTest();
        transaction1 = await Transaction.repo.save(Transaction.repo.create({
            transactionId: 1,
            userId: user1.id,
            roomId: room1.roomId,
            transactionStatus: 1
        }));
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
        duplicatedTransaction.userId = user1.id;
        duplicatedTransaction.roomId = room1.roomId;
        duplicatedTransaction.transactionId = 100;

        await Transaction.repo.save(duplicatedTransaction);

        const result = await Transaction.repo.find({transactionId: duplicatedTransaction.transactionId});
        expect(result).toBeTruthy();
    });

    it('should return right object after it was updated', async () => {
        const duplicatedTransaction = new Transaction();
        duplicatedTransaction.transactionId = 100;
        duplicatedTransaction.userId = user1.id;
        duplicatedTransaction.roomId = room1.roomId;

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
        duplicatedTransaction.userId = user1.id;
        duplicatedTransaction.roomId = room1.roomId;

        await Transaction.repo.save(duplicatedTransaction);
        await Transaction.repo.delete(duplicatedTransaction.transactionId);

        const result = await Building.repo.findOne({id: duplicatedTransaction.transactionId});
        expect(result).toBeUndefined();
    });

});
