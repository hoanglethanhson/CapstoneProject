import {QueryFailedError} from 'typeorm';
import {DatabaseManager} from '../../src/models';
import {Service} from '../../src/models/service';

describe('[model] service', () => {
    beforeAll(async () => {
        await DatabaseManager.init();
    });

    afterAll(async () => {
        await DatabaseManager.close();
    });

    let service1: Service;
    beforeEach(async () => {
        await DatabaseManager.clearDataServiceTest();
        service1 = new Service();
        service1.id = 1;
        service1.name = 'name';
        service1 = await Service.repo.save(service1);
    });


    it('should not insert duplicated name', async () => {
        // expect.assertions(1);
        try {
            const duplicatedService = new Service();
            duplicatedService.id = 2;
            duplicatedService.name = service1.name;
            await duplicatedService.save();
        } catch (error) {
            expect(error).toBeInstanceOf(QueryFailedError);
        }
    });


    it('should return null if service is not found', async () => {
        const result = await Service.repo.findOne(1000);
        expect(result).toBeUndefined();
    });

    it('should return true if service name is found', async () => {
        const result = await Service.repo.find({name: service1.name});
        expect(result).toBeTruthy();
    });

    it('should return false if service name is not found', async () => {
        const result = await Service.repo.findOne({name: "bla bla"});
        expect(result).toBeFalsy();
    });

    it('should return right object after it was inserted', async () => {
        const duplicatedService = new Service();
        duplicatedService.name = "wifi"

        await Service.repo.save(duplicatedService);

        const result = await Service.repo.find({name: duplicatedService.name});
        expect(result).toBeTruthy();
    });

    it('should return right object after it was updated', async () => {
        const duplicatedService = new Service();
        duplicatedService.name = "wifi"

        await Service.repo.save(duplicatedService);

        let updateService = duplicatedService;
        updateService.name = 'new wifi';
        await Service.repo.updateById(duplicatedService.id, updateService);

        const result = await Service.repo.find({name: updateService.name});
        expect(result).toBeTruthy();
    });

    it('should return null object after it was deleted', async () => {
        const duplicatedService = new Service();
        duplicatedService.name = "wifi"

        await Service.repo.save(duplicatedService);

        await Service.repo.delete(duplicatedService.id);

        const result = await Service.repo.findOne(duplicatedService.id);
        expect(result).toBeUndefined();
    });
});
