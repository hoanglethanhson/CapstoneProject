import {QueryFailedError} from 'typeorm';
import {DatabaseManager} from '../../src/models';
import {SavedRoom} from '../../src/models/saved-room';
import {RoomGroup} from "../../src/models/room-group";


describe('[model] savedRoom', () => {
    let roomGroup1 = new RoomGroup();
    beforeAll(async () => {
        await DatabaseManager.init();
        roomGroup1.id = 1;
        //roomGroup1 = await RoomGroup.repo.save(roomGroup1);
    });

    afterAll(async () => {
        await DatabaseManager.close();
    });

    let savedRoom1: SavedRoom;
    beforeEach(async () => {
        await DatabaseManager.clearData();
        await DatabaseManager.insertData();

        savedRoom1 = new SavedRoom();
        savedRoom1.userId = 1;
        savedRoom1.roomGroupId = 1;

        savedRoom1 = await SavedRoom.repo.save(savedRoom1);
    });


    it('should return null if savedRoom is not found', async () => {
        const result = await SavedRoom.repo.findOne({userId: 100});
        expect(result).toBeUndefined();
    });

    it('should return true if savedRoom name is found', async () => {
        const result = await SavedRoom.repo.find({userId: 1, roomGroupId: 1});
        expect(result).toBeTruthy();
    });


    it('should return right object after it was inserted', async () => {
        const duplicatedSavedRoom = new SavedRoom();
        duplicatedSavedRoom.userId = 1;
        duplicatedSavedRoom.roomGroupId = roomGroup1.id;

        await SavedRoom.repo.save(duplicatedSavedRoom);

        const result = await SavedRoom.repo.find({userId: 1, roomGroupId: 1});
        expect(result).toBeTruthy();
    });

    it('should return right object after it was updated', async () => {
        const duplicatedSavedRoom = new SavedRoom();
        duplicatedSavedRoom.userId = 1;
        duplicatedSavedRoom.roomGroupId = roomGroup1.id;

        await SavedRoom.repo.save(duplicatedSavedRoom);

        let updateSavedRoom = duplicatedSavedRoom;
        await SavedRoom.repo.updateById(duplicatedSavedRoom.userId, duplicatedSavedRoom.roomGroupId, updateSavedRoom);

        const result = await SavedRoom.repo.find({userId: 1, roomGroupId: 1});
        expect(result).toBeTruthy();
    });

    it('should return null object after it was deleted', async () => {
        const duplicatedSavedRoom = new SavedRoom();
        duplicatedSavedRoom.userId = 1;
        duplicatedSavedRoom.roomGroupId = roomGroup1.id;

        await SavedRoom.repo.save(duplicatedSavedRoom);
        await SavedRoom.repo.delete(duplicatedSavedRoom.userId);

        const result = await SavedRoom.repo.findOne({userId: duplicatedSavedRoom.userId});
        expect(result).toBeUndefined();
    });

});
