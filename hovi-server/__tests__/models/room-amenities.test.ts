import {QueryFailedError} from 'typeorm';
import {DatabaseManager} from '../../src/models';
import {RoomAmenities} from '../../src/models/room-amenities';
import {Amenities} from "../../src/models/amenities";

describe('[model] roomAmenities', () => {
    beforeAll(async () => {
        await DatabaseManager.init();
    });

    afterAll(async () => {
        await DatabaseManager.close();
    });

    let roomAmenities1: RoomAmenities;
    beforeEach(async () => {
        await DatabaseManager.clearData();
        await DatabaseManager.insertData();
        roomAmenities1 = new RoomAmenities();
        roomAmenities1.amenitiesId = 1;
        roomAmenities1.roomGroupId = 1;
        //roomAmenities1 = await RoomAmenities.repo.save(roomAmenities1);
    });


    it('should not insert duplicated amenities and roomGroup', async () => {
        // expect.assertions(1);
        try {
            let duplicatedRoomAmenities = new RoomAmenities();
            duplicatedRoomAmenities.amenitiesId = 100;
            duplicatedRoomAmenities.roomGroupId = 100;
            await duplicatedRoomAmenities.save();
        } catch (error) {
            expect(error).toBeInstanceOf(QueryFailedError);
        }
    });


    it('should return null if roomAmenities is not found', async () => {
        const result = await RoomAmenities.repo.getOneRecord(1000, 1000);
        expect(result).toBeUndefined();
    });

    it('should return true if roomAmenities name is found', async () => {
        const result = await RoomAmenities.repo.getOneRecord(1, 1);
        expect(result).toBeTruthy();
    });

    it('should return false if Amenities is not found', async () => {
        const result = await RoomAmenities.repo.getOneRecord(1, 1000);
        expect(result).toBeFalsy();
    });

    it('should return false if roomGroup is not found', async () => {
        const result = await RoomAmenities.repo.getOneRecord(1000, 1);
        expect(result).toBeFalsy();
    });

    it('should return right object after it was inserted', async () => {
        let amenities = new Amenities();
        amenities.id = 101;
        await amenities.save();

        let duplicatedRoomAmenities = new RoomAmenities();
        duplicatedRoomAmenities.amenitiesId = 1;
        duplicatedRoomAmenities.roomGroupId = 100;

        await RoomAmenities.repo.save(duplicatedRoomAmenities);

        const result = await RoomAmenities.repo.getOneRecord(duplicatedRoomAmenities.roomGroupId, duplicatedRoomAmenities.amenitiesId);
        expect(result).toBeTruthy();
    });

    it('should return right object after it was updated', async () => {
        let amenities = new Amenities();
        amenities.id = 101;
        await amenities.save();

        let amenitiesUpdate = new Amenities();
        amenities.id = 102;
        await amenities.save();

        let duplicatedRoomAmenities = new RoomAmenities();
        duplicatedRoomAmenities.amenitiesId = 1;
        duplicatedRoomAmenities.roomGroupId = 100;

        await RoomAmenities.repo.save(duplicatedRoomAmenities);

        let updateRoomAmenities = duplicatedRoomAmenities;
        updateRoomAmenities.amenitiesId = 102;
        await RoomAmenities.repo.updateById(duplicatedRoomAmenities.roomGroupId, duplicatedRoomAmenities.amenitiesId, updateRoomAmenities);

        const result = await RoomAmenities.repo.getOneRecord(duplicatedRoomAmenities.roomGroupId, duplicatedRoomAmenities.amenitiesId);
        expect(result).toBeFalsy();
    });

});
