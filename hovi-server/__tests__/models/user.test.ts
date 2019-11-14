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
        await DatabaseManager.clearDataUserTest();
        user1 = new User();
        user1.id = 1;
        user1.phoneNumber = 'phone number';
        user1 = await User.repo.save(user1);
    });


    it('should not insert duplicated phoneNumber', async () => {
        // expect.assertions(1);
        try {
            const duplicatedUser = new User();
            duplicatedUser.id = 2;
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

    it('should return right object after it was inserted', async () => {
        const duplicatedUser = new User();
        duplicatedUser.firstName = 'Insert first name';
        duplicatedUser.lastName = 'Insert last name';
        duplicatedUser.phoneNumber = '1234';
        duplicatedUser.email = 'insertuser1@mail.com';

        await User.repo.save(duplicatedUser);

        const result = await User.repo.find({phoneNumber: duplicatedUser.phoneNumber});
        expect(result).toBeTruthy();
    });

    it('should return right object after it was updated', async () => {
        const duplicatedUser = new User();
        duplicatedUser.firstName = 'Insert first name';
        duplicatedUser.lastName = 'Insert last name';
        duplicatedUser.phoneNumber = '1234';
        duplicatedUser.email = 'insertuser1@mail.com';

        await User.repo.save(duplicatedUser);

        let updateUser = duplicatedUser;
        updateUser.phoneNumber = '12345';
        await User.repo.updateById(duplicatedUser.id, updateUser);

        const result = await User.repo.find({phoneNumber: updateUser.phoneNumber});
        expect(result).toBeTruthy();
    });

    it('should return null object after it was deleted', async () => {
        const duplicatedUser = new User();
        duplicatedUser.firstName = 'Insert first name';
        duplicatedUser.lastName = 'Insert last name';
        duplicatedUser.phoneNumber = '1234';
        duplicatedUser.email = 'insertuser1@mail.com';

        await User.repo.save(duplicatedUser);
        await User.repo.delete(duplicatedUser.id);

        const result = await User.repo.findOne({phoneNumber: duplicatedUser.phoneNumber});
        expect(result).toBeUndefined();
    });
});
