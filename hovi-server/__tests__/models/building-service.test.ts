import {QueryFailedError} from 'typeorm';
import {DatabaseManager} from '../../src/models';
import {BuildingService} from '../../src/models/building-service';

describe('[model] buildingService', () => {
    beforeAll(async () => {
        await DatabaseManager.init();
    });

    afterAll(async () => {
        await DatabaseManager.close();
    });

    let buildingService1: BuildingService;
    beforeEach(async () => {
        await DatabaseManager.clearData();
        await DatabaseManager.insertData();
        buildingService1 = new BuildingService();
        buildingService1.buildingId = 1;
        buildingService1.serviceId = 1;
        buildingService1.servicePrice = 100;
        //buildingService1 = await BuildingService.repo.save(buildingService1);
    });


    it('should not insert duplicated building and service', async () => {
        // expect.assertions(1);
        try {
            const duplicatedBuildingService = new BuildingService();
            duplicatedBuildingService.buildingId = 1;
            duplicatedBuildingService.serviceId = 1;
            await duplicatedBuildingService.save();
        } catch (error) {
            expect(error).toBeInstanceOf(QueryFailedError);
        }
    });


    it('should return null if buildingService is not found', async () => {
        const result = await BuildingService.repo.getOneRecord(1000, 1000);
        expect(result).toBeUndefined();
    });

    it('should return true if buildingService name is found', async () => {
        const result = await BuildingService.repo.getOneRecord(1, 1);
        expect(result).toBeTruthy();
    });

    it('should return false if Amenities is not found', async () => {
        const result = await BuildingService.repo.getOneRecord(1, 1000);
        expect(result).toBeFalsy();
    });

    it('should return false if roomGroup is not found', async () => {
        const result = await BuildingService.repo.getOneRecord(1000, 1);
        expect(result).toBeFalsy();
    });

    it('should return right object after it was inserted', async () => {
        const duplicatedBuildingService = new BuildingService();
        duplicatedBuildingService.buildingId = 1;
        duplicatedBuildingService.serviceId = 1;

        await BuildingService.repo.save(duplicatedBuildingService);

        const result = await BuildingService.repo.getOneRecord(duplicatedBuildingService.buildingId, duplicatedBuildingService.serviceId);
        expect(result).toBeTruthy();
    });

    it('should return right object after it was updated', async () => {
        const duplicatedBuildingService = new BuildingService();
        duplicatedBuildingService.buildingId = 1;
        duplicatedBuildingService.serviceId = 1;
        duplicatedBuildingService.servicePrice = 100;

        await BuildingService.repo.save(duplicatedBuildingService);

        let updateBuildingService = duplicatedBuildingService;
        updateBuildingService.servicePrice = 200;
        await BuildingService.repo.updateById(duplicatedBuildingService.buildingId, duplicatedBuildingService.serviceId, updateBuildingService);

        const result = await BuildingService.repo.getOneRecord(duplicatedBuildingService.buildingId, duplicatedBuildingService.serviceId);
        expect(result.servicePrice).toBe(200);
    });

});
