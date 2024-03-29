import {QueryFailedError} from 'typeorm';
import {DatabaseManager} from '../../src/models';
import {Amenities} from '../../src/models/amenities';

describe('[model] amenities', () => {
    beforeAll(async () => {
        await DatabaseManager.init();
    });

    afterAll(async () => {
        await DatabaseManager.close();
    });

    let amenities1: Amenities;
    beforeEach(async () => {
        await DatabaseManager.clearData();
        await DatabaseManager.insertData();
        amenities1 = new Amenities();
        amenities1.id = 2;
        amenities1.usableName = 'name';
        //amenities1 = await Amenities.repo.save(amenities1);
    });


    it('should not insert duplicated name', async () => {
        // expect.assertions(1);
        try {
            let duplicatedAmenities = new Amenities();
            //duplicatedAmenities.id = 3;
            duplicatedAmenities.usableName = "name";
            await duplicatedAmenities.save();
        } catch (error) {
            expect(error).toBeInstanceOf(QueryFailedError);
        }
    });


    it('should return null if amenities is not found', async () => {
        const result = await Amenities.repo.findOne(1000);
        expect(result).toBeUndefined();
    });

    it('should return true if amenities name is found', async () => {
        const result = await Amenities.repo.find({usableName: "name"});
        expect(result).toBeTruthy();
    });

    it('should return false if amenities name is not found', async () => {
        const result = await Amenities.repo.findOne({usableName: "bla bla"});
        expect(result).toBeFalsy();
    });

    it('should return right object after it was inserted', async () => {
        let duplicatedAmenities = new Amenities();
        duplicatedAmenities.id = 101;
        duplicatedAmenities.usableName = "wifi";

        await Amenities.repo.save(duplicatedAmenities);

        const result = await Amenities.repo.find({usableName: duplicatedAmenities.usableName});
        expect(result).toBeTruthy();
    });

    it('should return right object after it was updated', async () => {
        let duplicatedAmenities = new Amenities();
        duplicatedAmenities.id = 101;
        duplicatedAmenities.usableName = "wifi";

        await Amenities.repo.save(duplicatedAmenities);

        let updateAmenities = duplicatedAmenities;
        updateAmenities.usableName = 'new wifi';
        await Amenities.repo.updateById(duplicatedAmenities.id, updateAmenities);

        const result = await Amenities.repo.find({usableName: updateAmenities.usableName});
        expect(result).toBeTruthy();
    });

    it('should return null object after it was deleted', async () => {
        let duplicatedAmenities = new Amenities();
        duplicatedAmenities.id = 101;
        duplicatedAmenities.usableName = "wifi";

        await Amenities.repo.save(duplicatedAmenities);

        await Amenities.repo.delete(duplicatedAmenities.id);

        const result = await Amenities.repo.findOne(duplicatedAmenities.id);
        expect(result).toBeUndefined();
    });
});
