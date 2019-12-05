import {getConnection, QueryFailedError} from 'typeorm';
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

        //savedRoom1 = await SavedRoom.repo.save(savedRoom1);
    });


    it('should return null if savedRoom is not found', async () => {
        const result = await SavedRoom.repo.findOne({userId: 10000});
        expect(result).toBeUndefined();
    });

    it('should return true if savedRoom name is found', async () => {
        const result = await SavedRoom.repo.find({userId: 100, roomGroupId: 100});
        expect(result).toBeTruthy();
    });


    it('should return right object after it was inserted', async () => {
        let duplicatedSavedRoom = new SavedRoom();
        duplicatedSavedRoom.userId = 100;
        duplicatedSavedRoom.roomGroupId = 100;

        await SavedRoom.repo.save(duplicatedSavedRoom);

        const result = await SavedRoom.repo.find({userId: 100, roomGroupId: 100});
        expect(result).toBeTruthy();
    });

    it('should return right object after it was updated', async () => {
        let duplicatedSavedRoom = new SavedRoom();
        duplicatedSavedRoom.userId = 100;
        duplicatedSavedRoom.roomGroupId = 100;

        await SavedRoom.repo.save(duplicatedSavedRoom);

        let updateSavedRoom = duplicatedSavedRoom;
        await SavedRoom.repo.updateById(duplicatedSavedRoom.userId, duplicatedSavedRoom.roomGroupId, updateSavedRoom);

        const result = await SavedRoom.repo.find({userId: 100, roomGroupId: 100});
        expect(result).toBeTruthy();
    });

    it('should return null object after it was deleted', async () => {
        let duplicatedSavedRoom = new SavedRoom();
        duplicatedSavedRoom.userId = 100;
        duplicatedSavedRoom.roomGroupId = 100;

        await SavedRoom.repo.save(duplicatedSavedRoom);
        await getConnection()
            .createQueryBuilder()
            .delete()
            .from(SavedRoom)
            .where("userId = :id", { id: 100})
            .andWhere('roomGroupId = :groupId', {groupId: 100})
            .execute();
        //await SavedRoom.repo.delete(duplicatedSavedRoom.userId);

        const result = await SavedRoom.repo.findOne({userId: duplicatedSavedRoom.userId, roomGroupId: duplicatedSavedRoom.roomGroupId});
        expect(result).toBeUndefined();
    });

});
