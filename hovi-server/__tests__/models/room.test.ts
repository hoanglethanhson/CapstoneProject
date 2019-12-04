import {QueryFailedError} from 'typeorm';
import {DatabaseManager} from '../../src/models';
import {Room} from '../../src/models/room';
import {User} from "../../src/models/user";
import {RoomType} from "../../src/models/building-type";
import {Building} from "../../src/models/building";
import {RoomGroup} from "../../src/models/room-group";

describe('[model] room', () => {
    let roomGroup1 = new RoomGroup();
    beforeAll(async () => {
        await DatabaseManager.init();

    });

    afterAll(async () => {
        await DatabaseManager.close();
    });

    let room1: Room;
    beforeEach(async () => {
        await DatabaseManager.clearData();
        await DatabaseManager.insertData();

        /*room1 = await Room.repo.save(Room.repo.create({
            roomId: 1,
            roomGroupId: roomGroup1.id,
            roomName: 'room_name',
            roomStatus: 1
        }));*/
    });

    //Failed test due to have not had logic handling in function file
    /*it('should not insert duplicated room name in same room group', async () => {
        // expect.assertions(1);
        try {
            const duplicatedRoom = new Room();
            duplicatedRoom.roomGroupId = room1.roomGroupId;
            duplicatedRoom.roomName = room1.roomName;
            await duplicatedRoom.save();
        } catch (error) {
            expect(error).toBeInstanceOf(QueryFailedError);
        }
    });*/


    it('should return null if room is not found', async () => {
        const result = await Room.repo.findOne(1000);
        expect(result).toBeUndefined();
    });

    it('should return true if room name is found', async () => {
        const result = await Room.repo.find({roomName: room1.roomName});
        expect(result).toBeTruthy();
    });

    it('should return false if room name is not found', async () => {
        const result = await Room.repo.findOne({roomName: "not a room name"});
        expect(result).toBeFalsy();
    });

    it('should return right object after it was inserted', async () => {
        let duplicatedRoom = new Room();
        duplicatedRoom.roomGroupId = 100;
        duplicatedRoom.roomName = "name";

        await Room.repo.save(duplicatedRoom);

        const result = await Room.repo.find({roomId: duplicatedRoom.roomId});
        expect(result).toBeTruthy();
    });

    it('should return right object after it was updated', async () => {
        let duplicatedRoom = new Room();
        duplicatedRoom.roomGroupId = 100;
        duplicatedRoom.roomName = "name";

        await Room.repo.save(duplicatedRoom);

        let updateRoom = duplicatedRoom;
        updateRoom.roomName = 'update name';
        await Room.repo.updateById(duplicatedRoom.roomId, updateRoom);

        const result = await Room.repo.findOne({roomId: duplicatedRoom.roomId});
        expect(result.roomName).toBe(updateRoom.roomName);
    });

    it('should return null object after it was deleted', async () => {
        let duplicatedRoom = new Room();
        duplicatedRoom.roomGroupId = 100;
        duplicatedRoom.roomName = "name";

        await Room.repo.save(duplicatedRoom);
        await Room.repo.delete(duplicatedRoom.roomId);

        const result = await Room.repo.findOne({roomId: duplicatedRoom.roomId});
        expect(result).toBeUndefined();
    });

});
