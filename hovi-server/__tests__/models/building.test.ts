import {DatabaseManager} from '../../src/models';
import {Building} from '../../src/models/building';
import {User} from "../../src/models/user";
import {RoomType} from "../../src/models/building-type";

describe('[model] building', () => {

    beforeAll(async () => {
        await DatabaseManager.init();
    });

    afterAll(async () => {
        await DatabaseManager.close();
    });

    let building1: Building;

    beforeEach(async () => {
        await DatabaseManager.clearData();
        building1 = new Building();
        building1.id = 1;

        building1 = await Building.repo.save(building1);
    });


    it('should return null if building is not found', async () => {
        const result = await Building.repo.findOne(1000);
        expect(result).toBeUndefined();
    });

    it('should return true if building name is found', async () => {
        const result = await Building.repo.find({buildingName: building1.buildingName});
        expect(result).toBeTruthy();
    });

    it('should return false if building name is not found', async () => {
        const result = await Building.repo.findOne({buildingName: "Do not set this to building name"});
        expect(result).toBeFalsy();
    });

    it('should return right object after it was inserted', async () => {
        const duplicatedBuilding = new Building();
        duplicatedBuilding.buildingName = "name";

        await Building.repo.save(duplicatedBuilding);

        const result = await Building.repo.find({buildingName: duplicatedBuilding.buildingName});
        expect(result).toBeTruthy();
    });

    it('should return right object after it was updated', async () => {
        const duplicatedBuilding = new Building();
        duplicatedBuilding.buildingName = "name";

        await Building.repo.save(duplicatedBuilding);

        let updateBuilding = duplicatedBuilding;
        updateBuilding.buildingName = 'update name';
        await Building.repo.updateById(duplicatedBuilding.id, updateBuilding);

        const result = await Building.repo.findOne({id: duplicatedBuilding.id});
        expect(result.buildingName).toBe(updateBuilding.buildingName);
    });

    it('should return null object after it was deleted', async () => {
        const duplicatedBuilding = new Building();
        duplicatedBuilding.buildingName = "name";

        await Building.repo.save(duplicatedBuilding);
        await Building.repo.delete(duplicatedBuilding.id);

        const result = await Building.repo.findOne({id: duplicatedBuilding.id});
        expect(result).toBeUndefined();
    });

});
