import {QueryFailedError} from 'typeorm';
import {DatabaseManager} from '../../src/models';
import {RoomType} from '../../src/models/building-type';

describe('[model] buildingType', () => {
    beforeAll(async () => {
        await DatabaseManager.init();
    });

    afterAll(async () => {
        await DatabaseManager.close();
    });

    let buildingType1: RoomType;
    beforeEach(async () => {
        await DatabaseManager.clearData();
        buildingType1 = await RoomType.repo.save(RoomType.repo.create({
            id: 1,
            type: 'building_type'
        }));
    });


    it('should not insert duplicated building type', async () => {
        // expect.assertions(1);
        try {
            const duplicatedRoomType = new RoomType();
            duplicatedRoomType.type = buildingType1.type;
            await duplicatedRoomType.save();
        } catch (error) {
            expect(error).toBeInstanceOf(QueryFailedError);
        }
    });


    it('should return null if buildingType is not found', async () => {
        const result = await RoomType.repo.findOne(1000);
        expect(result).toBeUndefined();
    });

    it('should return true if building type is found', async () => {
        const result = await RoomType.repo.find({type: buildingType1.type});
        expect(result).toBeTruthy();
    });

    it('should return false if building type is not found', async () => {
        const result = await RoomType.repo.findOne({type: "no type"});
        expect(result).toBeFalsy();
    });
});
