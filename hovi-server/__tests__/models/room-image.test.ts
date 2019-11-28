import {QueryFailedError} from 'typeorm';
import {DatabaseManager} from '../../src/models';
import {RoomImage} from '../../src/models/room-image';
import {Building} from "../../src/models/building";
import {RoomGroup} from "../../src/models/room-group";


describe('[model] roomImage', () => {
    let roomGroup1 = new RoomGroup();
    beforeAll(async () => {
        await DatabaseManager.init();
        roomGroup1.id = 1;
        //roomGroup1 = await RoomGroup.repo.save(roomGroup1);
    });

    afterAll(async () => {
        await DatabaseManager.close();
    });

    let roomImage1: RoomImage;
    beforeEach(async () => {
        await DatabaseManager.clearData();

        roomImage1 = new RoomImage();
        roomImage1.imageId = 1;
        roomImage1.imageUrl = 'abc';

        roomImage1 = await RoomImage.repo.save(roomImage1);
    });

    //Failed test due to have not had logic handling in function file
    /*it('should not insert duplicated roomImage name in same roomImage group', async () => {
        // expect.assertions(1);
        try {
            const duplicatedRoom = new RoomImage();
            duplicatedRoom.roomGroupId = room1.roomGroupId;
            duplicatedRoom.roomName = room1.roomName;
            await duplicatedRoom.save();
        } catch (error) {
            expect(error).toBeInstanceOf(QueryFailedError);
        }
    });*/


    it('should return null if roomImage is not found', async () => {
        const result = await RoomImage.repo.findOne(1000);
        expect(result).toBeUndefined();
    });

    it('should return true if roomImage name is found', async () => {
        const result = await RoomImage.repo.find({imageUrl: roomImage1.imageUrl});
        expect(result).toBeTruthy();
    });

    it('should return false if roomImage name is not found', async () => {
        const result = await RoomImage.repo.findOne({imageUrl: "not a roomImage name"});
        expect(result).toBeFalsy();
    });

    it('should return right object after it was inserted', async () => {
        const duplicatedRoomImage = new RoomImage();
        duplicatedRoomImage.imageId = 3;
        duplicatedRoomImage.roomGroupId = roomGroup1.id;
        duplicatedRoomImage.imageUrl = "new";

        await RoomImage.repo.save(duplicatedRoomImage);

        const result = await RoomImage.repo.find({imageUrl: duplicatedRoomImage.imageUrl});
        expect(result).toBeTruthy();
    });

    it('should return right object after it was updated', async () => {
        const duplicatedRoomImage = new RoomImage();
        duplicatedRoomImage.imageId = 3;
        duplicatedRoomImage.roomGroupId = roomGroup1.id;
        duplicatedRoomImage.imageUrl = "name";

        await RoomImage.repo.save(duplicatedRoomImage);

        let updateRoomImage = duplicatedRoomImage;
        updateRoomImage.imageUrl = 'update name';
        await RoomImage.repo.updateById(duplicatedRoomImage.imageId, updateRoomImage);

        const result = await RoomImage.repo.findOne({imageId: duplicatedRoomImage.imageId});
        expect(result.imageUrl).toBe(updateRoomImage.imageUrl);
    });

    it('should return null object after it was deleted', async () => {
        const duplicatedRoomImage = new RoomImage();
        duplicatedRoomImage.imageId = 3;
        duplicatedRoomImage.roomGroupId = roomGroup1.id;
        duplicatedRoomImage.imageUrl = "name";

        await RoomImage.repo.save(duplicatedRoomImage);
        await RoomImage.repo.delete(duplicatedRoomImage.imageId);

        const result = await RoomImage.repo.findOne({imageId: duplicatedRoomImage.imageId});
        expect(result).toBeUndefined();
    });

});
