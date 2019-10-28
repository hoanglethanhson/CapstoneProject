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
    });


    it('should not insert duplicated phoneNumber', async () => {
        // expect.assertions(1);
        try {
            const duplicatedUser = new User();
            duplicatedUser.firstName = 'Duplicated firstName of user1';
            duplicatedUser.lastName = 'Duplicated lastName of user1';
            duplicatedUser.phoneNumber = user1.phoneNumber;
            duplicatedUser.email = 'duplicateduser1@mail.com';
            await duplicatedUser.save();
        } catch (error) {
            expect(error).toBeInstanceOf(QueryFailedError);
        }
    });


    it('should return null if user is not found', async () => {
        const result = await User.repo.findOne(1000);
        expect(result).toBeUndefined();
    });

    it('should return true if phone number is found', async () => {
        const result = await User.repo.find({phoneNumber: user1.phoneNumber});
        expect(result).toBeTruthy();
    });

    it('should return false if phone number is not found', async () => {
        const result = await User.repo.findOne({phoneNumber: "phoneNumber"});
        expect(result).toBeFalsy();
    });
});
