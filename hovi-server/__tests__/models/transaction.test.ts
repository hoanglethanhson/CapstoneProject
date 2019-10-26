import {QueryFailedError} from 'typeorm';
import {DatabaseManager} from '../../src/models';
import {Transaction} from '../../src/models/transaction';
import {User} from "../../src/models/user";
import {RoomGroup} from "../../src/models/room-group";

describe('[model] transaction', () => {
    beforeAll(async () => {
        await DatabaseManager.init();
    });

    afterAll(async () => {
        await DatabaseManager.close();
    });

    let transaction1: Transaction;
    beforeEach(async () => {
        await DatabaseManager.clearData();
        const user1 = await User.repo.save(User.repo.create({
            id: 1,
            firstName: 'first_name',
            lastName: 'last_name',
            phoneNumber: 'phone_number',
            password: 'password',
            phoneToken: 'phone_token',
            roleAdmin: 'role_admin',
            gender: true,
            facebookId: 'facebook_id',
            googleId: 'google_id',
            email: 'email',
            avatar: 'avatar',
            address: 'address',
            isVerified: true,
            isHost: true,
            isActive: true
        }));

        //TODO : Declare variables for building, roomGroup and room

        transaction1 = await Transaction.repo.save(Transaction.repo.create({
            transactionId: 1,
            userId: 1,
            roomId: 1,
            isTransited: true
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
});
