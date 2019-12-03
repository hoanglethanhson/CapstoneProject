import {QueryFailedError} from 'typeorm';
import {DatabaseManager} from '../../src/models';
import {Feedback} from '../../src/models/feedback';

describe('[model] feedback', () => {

    beforeAll(async () => {
        await DatabaseManager.init();
    });

    afterAll(async () => {
        await DatabaseManager.close();
    });

    let feedback1: Feedback;
    beforeEach(async () => {
        await DatabaseManager.clearData();
        await DatabaseManager.insertData();
        feedback1 = new Feedback();
        feedback1.feedbackId = 1;
        feedback1.content = 'nice';

        //feedback1 = await Feedback.repo.save(feedback1);
    });

    it('should return null if feedback is not found', async () => {
        const result = await Feedback.repo.findOne(1000);
        expect(result).toBeUndefined();
    });

    it('should return true if feedback id is found', async () => {
        const result = await Feedback.repo.find({feedbackId: feedback1.feedbackId});
        expect(result).toBeTruthy();
    });

    it('should return false if building id is not found', async () => {
        const result = await Feedback.repo.findOne({feedbackId: 100000});
        expect(result).toBeFalsy();
    });

    it('should return right object after it was inserted', async () => {
        const duplicatedFeedback = new Feedback();
        duplicatedFeedback.feedbackId = 200;

        await Feedback.repo.save(duplicatedFeedback);

        const result = await Feedback.repo.find({feedbackId: duplicatedFeedback.feedbackId});
        expect(result).toBeTruthy();
    });

    it('should return right object after it was updated', async () => {
        const duplicatedFeedback = new Feedback();
        duplicatedFeedback.feedbackId = 200;

        await Feedback.repo.save(duplicatedFeedback);

        let updateFeedback = duplicatedFeedback;
        updateFeedback.content = 'update direction';
        await Feedback.repo.updateById(duplicatedFeedback.feedbackId, updateFeedback);

        const result = await Feedback.repo.findOne({feedbackId: duplicatedFeedback.feedbackId});
        expect(result.content).toBe(updateFeedback.content);
    });

    it('should return null object after it was deleted', async () => {
        const duplicatedFeedback = new Feedback();
        duplicatedFeedback.feedbackId = 200;

        await Feedback.repo.save(duplicatedFeedback);
        await Feedback.repo.delete(duplicatedFeedback.feedbackId);

        const result = await Feedback.repo.findOne({feedbackId: duplicatedFeedback.feedbackId});
        expect(result).toBeUndefined();
    });

});
