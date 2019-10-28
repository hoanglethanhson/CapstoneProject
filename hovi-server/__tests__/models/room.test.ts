import {QueryFailedError} from 'typeorm';
import {DatabaseManager} from '../../src/models';
import {Room} from '../../src/models/room';
import {User} from "../../src/models/user";
import {RoomType} from "../../src/models/building-type";
import {Building} from "../../src/models/building";
import {RoomGroup} from "../../src/models/room-group";

describe('[model] room', () => {
    beforeAll(async () => {
        await DatabaseManager.init();
    });

    afterAll(async () => {
        await DatabaseManager.close();
    });

    let room1: Room;
    beforeEach(async () => {
        await DatabaseManager.clearData();

        const user1 = await User.repo.save(User.repo.create({
            id: 1,
            firstName: 'first_name',
            lastName: 'last_name',
            phoneNumber: 'phone_number',
            password: 'password',
            phoneToken: 'phone_token',
            roleAdmin: 'role_admin',
            gender: true,
            facebookId: 'facebook_id',
            googleId: 'google_id',
            email: 'email',
            avatar: 'avatar',
            address: 'address',
            isVerified: true,
            isHost: true,
            isActive: true
        }));

        const buildingType1 = await RoomType.repo.save(RoomType.repo.create({
            id: 1,
            type: 'building_type'
        }));

        const building1 = await Building.repo.save(Building.repo.create({
            id: 1,
            buildingName: 'building_name',
            typeId: buildingType1.id,
            isMixGender: true,
            province: 'province',
            district: 'district',
            ward: 'ward',
            street: 'street',
            detailedAddress: 'detailed_address',
            location: 'location',
            floor: 2,
            hostId: user1.id,
            isVerified: true,
            isCompleted: 3,
        }));

        const roomGroup1 = await RoomGroup.repo.save(RoomGroup.repo.create({
            id: 1,
            buildingId: building1.id,
            gender: true,
            rentPrice: 1200,
            area: 12,
            bedroomQuantity: 1,
            bathroomQuantity: 1,
            wcQuantity: 1,
            direction: 'direction',
            isAvailable: true,
            isVerified: true,
            depositPrice: 100,
            description: 'description',
            capacity: 1,
            quantity: 2,
            viewAmount: 100,
            phoneViewAmount: 10,
            isSponsored: false
        }));

        room1 = await Room.repo.save(Room.repo.create({
            roomId: 1,
            roomGroupId: roomGroup1.id,
            roomName: 'room_name',
            roomStatus: 1
        }));
    });


    it('should not insert duplicated room name in same room group', async () => {
        // expect.assertions(1);
        try {
            const duplicatedRoom = new Room();
            duplicatedRoom.roomGroupId = room1.roomGroupId;
            duplicatedRoom.roomName = room1.roomName;
            await duplicatedRoom.save();
        } catch (error) {
            expect(error).toBeInstanceOf(QueryFailedError);
        }
    });


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
});
