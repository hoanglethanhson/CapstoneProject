import {DatabaseManager} from '../../src/models';
import {SystemInformation} from '../../src/models/system-information';

describe('[model] systemInformation', () => {

    beforeAll(async () => {
        await DatabaseManager.init();
    });

    afterAll(async () => {
        await DatabaseManager.close();
    });

    let info1: SystemInformation;

    beforeEach(async () => {
        await DatabaseManager.clearData();
        await DatabaseManager.insertData();
        info1 = new SystemInformation();
        info1.info_id = 2;
        info1.title = "A";

        info1 = await SystemInformation.repo.save(info1);
    });


    it('should return null if info is not found', async () => {
        const result = await SystemInformation.repo.findOne(1000);
        expect(result).toBeUndefined();
    });

    it('should return true if info name is found', async () => {
        const result = await SystemInformation.repo.find({info_id: info1.info_id});
        expect(result).toBeTruthy();
    });

    it('should return false if title name is not found', async () => {
        const result = await SystemInformation.repo.findOne({title: "Do not set this to info name"});
        expect(result).toBeFalsy();
    });

    it('should return right object after it was inserted', async () => {
        const duplicatedAccount = new SystemInformation();
        duplicatedAccount.info_id = 3;

        await SystemInformation.repo.save(duplicatedAccount);

        const result = await SystemInformation.repo.find({info_id: duplicatedAccount.info_id});
        expect(result).toBeTruthy();
    });

    it('should return right object after it was updated', async () => {
        const duplicatedAccount = new SystemInformation();
        duplicatedAccount.info_id = 3;

        await SystemInformation.repo.save(duplicatedAccount);

        let updateBuilding = duplicatedAccount;
        updateBuilding.title = 'update name';
        await SystemInformation.repo.updateById(duplicatedAccount.info_id, updateBuilding);

        const result = await SystemInformation.repo.findOne({info_id: duplicatedAccount.info_id});
        expect(result.title).toBe(updateBuilding.title);
    });

    it('should return null object after it was deleted', async () => {
        const duplicatedAccount = new SystemInformation();
        duplicatedAccount.info_id = 3;

        await SystemInformation.repo.save(duplicatedAccount);
        await SystemInformation.repo.delete(duplicatedAccount.info_id);

        const result = await SystemInformation.repo.findOne({info_id: duplicatedAccount.info_id});
        expect(result).toBeUndefined();
    });

});
