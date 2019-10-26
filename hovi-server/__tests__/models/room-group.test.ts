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

        roomGroup1 = await RoomGroup.repo.save(RoomGroup.repo.create({
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


    });



    it('should return null if roomGroup is not found', async () => {
        const result = await RoomGroup.repo.findOne(1000);
        expect(result).toBeUndefined();
    });

    it('should return true if building id is found', async () => {
        const result = await RoomGroup.repo.find({buildingId: roomGroup1.buildingId});
        expect(result).toBeTruthy();
    });

    it('should return false if building id is not found', async () => {
        const result = await RoomGroup.repo.findOne({buildingId: 100000});
        expect(result).toBeFalsy();
    });
});
