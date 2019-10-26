import {QueryFailedError} from 'typeorm';
import {DatabaseManager} from '../../src/models';
import {Building} from '../../src/models/building';
import {User} from "../../src/models/user";
import {RoomType} from "../../src/models/building-type";

describe('[model] building', () => {
    beforeAll(async () => {
        await DatabaseManager.init();
    });

    afterAll(async () => {
        await DatabaseManager.close();
    });

    let building1: Building;
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

        building1 = await Building.repo.save(Building.repo.create({
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
    });


    it('should return null if building is not found', async () => {
        const result = await Building.repo.findOne(1000);
        expect(result).toBeUndefined();
    });

    it('should return true if building name is found', async () => {
        const result = await Building.repo.find({buildingName: building1.buildingName});
        expect(result).toBeTruthy();
    });

    it('should return false if building name is not found', async () => {
        const result = await Building.repo.findOne({buildingName: "Do not set this to building name"});
        expect(result).toBeFalsy();
    });
});
