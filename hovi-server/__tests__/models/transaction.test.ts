import {QueryFailedError} from 'typeorm';
import {DatabaseManager} from '../../src/models';
import {Transaction} from '../../src/models/transaction';
import {User} from "../../src/models/user";
import {RoomGroup} from "../../src/models/room-group";
import {RoomType} from "../../src/models/building-type";
import {Building} from "../../src/models/building";
import {Room} from "../../src/models/room";

describe('[model] transaction', () => {
    beforeAll(async () => {
        await DatabaseManager.init();
    });

    afterAll(async () => {
        await DatabaseManager.close();
    });

    let transaction1: Transaction;
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

        //TODO : Declare variables for building, roomGroup and room
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

        const room1 = await Room.repo.save(Room.repo.create({
            roomId: 1,
            roomGroupId: roomGroup1.id,
            roomName: 'room_name',
            roomStatus: 1
        }));

        transaction1 = await Transaction.repo.save(Transaction.repo.create({
            transactionId: 1,
            userId: user1.id,
            roomId: room1.roomId,
            isTransited: true
        }));
    });



    it('should return null if transaction is not found', async () => {
        const result = await Transaction.repo.findOne(1000);
        expect(result).toBeUndefined();
    });


    it('should return false if user id is not found', async () => {
        const result = await Transaction.repo.findOne({userId: 1000});
        expect(result).toBeFalsy();
    });

    it('should return false if room id is not found', async () => {
        const result = await Transaction.repo.findOne({roomId: 1000});
        expect(result).toBeFalsy();
    });
});
