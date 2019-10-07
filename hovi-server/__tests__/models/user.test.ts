/*
import {QueryFailedError} from 'typeorm';
import {DatabaseManager} from '../../src/models';
import {User} from '../../src/models/user';

describe('[model] user', () => {
    beforeAll(async () => {
        await DatabaseManager.init();
    });

    afterAll(async () => {
        await DatabaseManager.close();
    });

    let user1: User;
    beforeEach(async () => {
        await DatabaseManager.clearData();
        user1 = await User.repo.save(User.repo.create({
            id: 1,
            userName: 'user1',
            fullName: 'User 1',
            phoneNumber: '0123456789',
            email: 'user1@mail.com',
        }));
    });

    it('should not insert duplicated userName', async () => {
        // expect.assertions(1);
        try {
            const duplicatedUser = new User();
            duplicatedUser.userName = user1.userName;
            duplicatedUser.fullName = 'Duplicated userName of user1';
            duplicatedUser.phoneNumber = '0213456789';
            duplicatedUser.email = 'duplicateduser1@mail.com';
            await duplicatedUser.save();
        } catch (error) {
            expect(error).toBeInstanceOf(QueryFailedError);
        }
    });

    it('should not insert duplicated phoneNumber', async () => {
        // expect.assertions(1);
        try {
            const duplicatedUser = new User();
            duplicatedUser.userName = 'user2';
            duplicatedUser.fullName = 'Duplicated phoneNumber of user1';
            duplicatedUser.phoneNumber = user1.phoneNumber;
            duplicatedUser.email = 'duplicateduser1@mail.com';
            await duplicatedUser.save();
        } catch (error) {
            expect(error).toBeInstanceOf(QueryFailedError);
        }
    });

    it('should not insert duplicated email', async () => {
        // expect.assertions(1);
        try {
            const duplicatedUser = new User();
            duplicatedUser.userName = 'user2';
            duplicatedUser.fullName = 'Duplicated email of user1';
            duplicatedUser.phoneNumber = '0213456789';
            duplicatedUser.email = user1.email;
            await duplicatedUser.save();
        } catch (error) {
            expect(error).toBeInstanceOf(QueryFailedError);
        }
    });

    it('should return null if user is not found', async () => {
        const result = await User.repo.findOne(1000);
        expect(result).toBeUndefined();
    });

    it('should return true if userName is found', async () => {
        const result = await User.repo.find({userName: user1.userName});
        expect(result).toBeTruthy();
    });

    it('should return false if userName is not found', async () => {
        const result = await User.repo.findOne('not-exist-userName');
        expect(result).toBeFalsy();
    });
});
*/
