import {DatabaseManager} from '../../src/models';
import {Building} from '../../src/models/building';
import {User} from "../../src/models/user";
import {RoomType} from "../../src/models/building-type";

describe('[model] building', () => {
    let user1: User;
    let buildingType1: RoomType;
    beforeAll(async () => {
        await DatabaseManager.init();
        user1 = await User.repo.save(User.repo.create({
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

        buildingType1 = await RoomType.repo.save(RoomType.repo.create({
            id: 1,
            type: 'building_type'
        }));
    });

    afterAll(async () => {
        await DatabaseManager.close();
    });

    let building1: Building;

    beforeEach(async () => {
        await DatabaseManager.clearDataBuildingTest();


        building1 = await Building.repo.save(Building.repo.create({
            id: 1,
            buildingName: 'building_create',
            typeId: buildingType1.id,
            province: 'province',
            district: 'district',
            ward: 'ward',
            detailedAddress: 'detailed_address',
            addressDescription: 'address_description',
            location: 'location',
            floorQuantity: 1,
            hostId: user1.id,
            isVerified: true,
            isCompleted: 1
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

    it('should return right object after it was inserted', async () => {
        const duplicatedBuilding = new Building();
        duplicatedBuilding.buildingName = "name";

        await Building.repo.save(duplicatedBuilding);

        const result = await Building.repo.find({buildingName: duplicatedBuilding.buildingName});
        expect(result).toBeTruthy();
    });

    it('should return right object after it was updated', async () => {
        const duplicatedBuilding = new Building();
        duplicatedBuilding.buildingName = "name";

        await Building.repo.save(duplicatedBuilding);

        let updateBuilding = duplicatedBuilding;
        updateBuilding.buildingName = 'update name';
        await Building.repo.updateById(duplicatedBuilding.id, updateBuilding);

        const result = await Building.repo.findOne({id: duplicatedBuilding.id});
        expect(result.buildingName).toBe(updateBuilding.buildingName);
    });

    it('should return null object after it was deleted', async () => {
        const duplicatedBuilding = new Building();
        duplicatedBuilding.buildingName = "name";

        await Building.repo.save(duplicatedBuilding);
        await Building.repo.delete(duplicatedBuilding.id);

        const result = await Building.repo.findOne({id: duplicatedBuilding.id});
        expect(result).toBeUndefined();
    });

});
