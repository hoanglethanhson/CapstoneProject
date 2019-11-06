import {QueryFailedError} from 'typeorm';
import {DatabaseManager} from '../../src/models';
import {RoomGroup} from '../../src/models/room-group';
import {User} from "../../src/models/user";
import {RoomType} from "../../src/models/building-type";
import {Building} from "../../src/models/building";

describe('[model] roomGroup', () => {
    let user1 = new User();
    let buildingType1 = new RoomType();
    let building1 = new Building();

    beforeAll(async () => {
        await DatabaseManager.init();
        user1.id = 1;
        buildingType1.id = 1;
        building1.id = 1;
        user1 = await User.repo.save(user1);
        buildingType1 = await RoomType.repo.save(buildingType1);
        building1 = await Building.repo.save(building1);
    });

    afterAll(async () => {
        await DatabaseManager.close();
    });

    let roomGroup1: RoomGroup;
    beforeEach(async () => {
        await DatabaseManager.clearDataRoomGroupTest();

        roomGroup1 = await RoomGroup.repo.save(RoomGroup.repo.create({
            id: 1,
            buildingId: building1.id,
            gender: true,
            rentPrice: 1,
            minDepositPeriod: 1,
            area: 1,
            bedroomQuantity: 1,
            bathroomQuantity: 1,
            wcQuantity: 1,
            direction: 'direction',
            isAvailable: true,
            isVerified: true,
            depositPrice: 1,
            description: 'description',
            capacity: 1,
            viewAmount: 1,
            phoneViewAmount: 1,
            isSponsored: true
        }));
    });

    it('should return null if roomGroup is not found', async () => {
        const result = await RoomGroup.repo.findOne(1000);
        expect(result).toBeUndefined();
    });

    it('should return true if roomGroup id is found', async () => {
        const result = await RoomGroup.repo.find({buildingId: roomGroup1.buildingId});
        expect(result).toBeTruthy();
    });

    it('should return false if building id is not found', async () => {
        const result = await RoomGroup.repo.findOne({buildingId: 100000});
        expect(result).toBeFalsy();
    });

    it('should return right object after it was inserted', async () => {
        const duplicatedRoomGroup = new RoomGroup();
        duplicatedRoomGroup.id = 200;

        await RoomGroup.repo.save(duplicatedRoomGroup);

        const result = await RoomGroup.repo.find({id: duplicatedRoomGroup.id});
        expect(result).toBeTruthy();
    });

    it('should return right object after it was updated', async () => {
        const duplicatedRoomGroup = new RoomGroup();
        duplicatedRoomGroup.id = 200;

        await RoomGroup.repo.save(duplicatedRoomGroup);

        let updateRoomGroup = duplicatedRoomGroup;
        updateRoomGroup.direction = 'update direction';
        await RoomGroup.repo.updateById(duplicatedRoomGroup.id, updateRoomGroup);

        const result = await RoomGroup.repo.findOne({id: duplicatedRoomGroup.id});
        expect(result.direction).toBe(updateRoomGroup.direction);
    });

    it('should return null object after it was deleted', async () => {
        const duplicatedRoomGroup = new RoomGroup();
        duplicatedRoomGroup.id = 200;

        await RoomGroup.repo.save(duplicatedRoomGroup);
        await RoomGroup.repo.delete(duplicatedRoomGroup.id);

        const result = await RoomGroup.repo.findOne({id: duplicatedRoomGroup.id});
        expect(result).toBeUndefined();
    });

});
