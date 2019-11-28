import {QueryFailedError} from 'typeorm';
import {DatabaseManager} from '../../src/models';
import {TenantReview} from '../../src/models/tenant-review';
import {RoomGroup} from "../../src/models/room-group";

describe('[model] tenantReview', () => {
    let roomGroup1 = new RoomGroup();
    beforeAll(async () => {
        await DatabaseManager.init();
        roomGroup1.id = 1;
        //roomGroup1 = await RoomGroup.repo.save(roomGroup1);
    });

    afterAll(async () => {
        await DatabaseManager.close();
    });

    let review1: TenantReview;
    beforeEach(async () => {
        await DatabaseManager.clearData();

        review1 = new TenantReview();
        review1.reviewId = 1;
        review1.comment = "comment";

        review1 = await TenantReview.repo.save(review1);
    });



    it('should return null if tenantReview is not found', async () => {
        const result = await TenantReview.repo.findOne(1000);
        expect(result).toBeUndefined();
    });

    it('should return true if tenantReview name is found', async () => {
        const result = await TenantReview.repo.find({comment: review1.comment});
        expect(result).toBeTruthy();
    });

    it('should return false if tenantReview name is not found', async () => {
        const result = await TenantReview.repo.findOne({comment: "not a tenantReview name"});
        expect(result).toBeFalsy();
    });

    it('should return right object after it was inserted', async () => {
        const duplicatedReview = new TenantReview();
        //duplicatedReview.roomGroupId = roomGroup1.id;
        duplicatedReview.comment = "name";

        await TenantReview.repo.save(duplicatedReview);

        const result = await TenantReview.repo.find({comment: duplicatedReview.comment});
        expect(result).toBeTruthy();
    });

    it('should return right object after it was updated', async () => {
        const duplicatedReview = new TenantReview();
        duplicatedReview.reviewId = 3;
        //duplicatedReview.roomGroupId = roomGroup1.id;
        duplicatedReview.comment = "name";

        await TenantReview.repo.save(duplicatedReview);

        let updateReview = duplicatedReview;
        updateReview.comment = 'update name';
        await TenantReview.repo.updateById(duplicatedReview.reviewId, updateReview);

        const result = await TenantReview.repo.findOne({reviewId: duplicatedReview.reviewId});
        expect(result.comment).toBe(updateReview.comment);
    });

    it('should return null object after it was deleted', async () => {
        const duplicatedReview = new TenantReview();
        duplicatedReview.reviewId = 3;
        //duplicatedReview.roomGroupId = roomGroup1.id;
        duplicatedReview.comment = "name";

        await TenantReview.repo.save(duplicatedReview);
        await TenantReview.repo.delete(duplicatedReview.reviewId);

        const result = await TenantReview.repo.findOne({reviewId: duplicatedReview.reviewId});
        expect(result).toBeUndefined();
    });

});
