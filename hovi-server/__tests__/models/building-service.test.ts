import {QueryFailedError} from 'typeorm';
import {DatabaseManager} from '../../src/models';
import {BuildingService} from '../../src/models/building-service';
import {Service} from "../../src/models/service";

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
            let duplicatedBuildingService = new BuildingService();
            duplicatedBuildingService.buildingId = 100;
            duplicatedBuildingService.serviceId = 100;
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
        const result = await BuildingService.repo.getOneRecord(100, 100);
        expect(result).toBeTruthy();
    });

    it('should return false if service is not found', async () => {
        const result = await BuildingService.repo.getOneRecord(1, 1000);
        expect(result).toBeFalsy();
    });

    it('should return false if roomGroup is not found', async () => {
        const result = await BuildingService.repo.getOneRecord(1000, 1);
        expect(result).toBeFalsy();
    });

    it('should return right object after it was inserted', async () => {
        let service = new Service()
        service.id = 101;
        await service.save();

        let duplicatedBuildingService = new BuildingService();
        duplicatedBuildingService.buildingId = 100;
        duplicatedBuildingService.serviceId = 101;

        await BuildingService.repo.save(duplicatedBuildingService);

        const result = await BuildingService.repo.getOneRecord(duplicatedBuildingService.buildingId, duplicatedBuildingService.serviceId);
        expect(result).toBeTruthy();
    });

    it('should return right object after it was updated', async () => {
        let service = new Service()
        service.id = 101;
        await service.save();

        let duplicatedBuildingService = new BuildingService();
        duplicatedBuildingService.buildingId = 100;
        duplicatedBuildingService.serviceId = 100;

        let updateBuildingService = duplicatedBuildingService;
        updateBuildingService.servicePrice = 200;
        await BuildingService.repo.updateById(duplicatedBuildingService.buildingId, duplicatedBuildingService.serviceId, updateBuildingService);

        const result = await BuildingService.repo.getOneRecord(100, 100);
        expect(result.servicePrice).toBe(200);
    });

});
