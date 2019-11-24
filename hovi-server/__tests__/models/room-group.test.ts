import {QueryFailedError} from 'typeorm';
import {DatabaseManager} from '../../src/models';
import {RoomGroup} from '../../src/models/room-group';
import {User} from "../../src/models/user";
import {RoomType} from "../../src/models/building-type";
import {Building} from "../../src/models/building";

describe('[model] roomGroup', () => {

    beforeAll(async () => {
        await DatabaseManager.init();
    });

    afterAll(async () => {
        await DatabaseManager.close();
    });

    let roomGroup1: RoomGroup;
    beforeEach(async () => {
        await DatabaseManager.clearData();
        await DatabaseManager.insertData();
        roomGroup1 = new RoomGroup();
        roomGroup1.id = 2;
        roomGroup1.buildingId = 1;

        //roomGroup1 = await RoomGroup.repo.save(roomGroup1);
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
