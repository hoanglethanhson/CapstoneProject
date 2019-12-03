import {DatabaseManager} from '../../src/models';
import {ReportedRoom} from '../../src/models/reported-room';
import {RoomGroup} from "../../src/models/room-group";

describe('[model] reportedRoom', () => {
    let roomGroup1 = new RoomGroup();
    beforeAll(async () => {
        await DatabaseManager.init();
        roomGroup1.id = 1;
        //roomGroup1 = await RoomGroup.repo.save(roomGroup1);
    });

    afterAll(async () => {
        await DatabaseManager.close();
    });

    let report1: ReportedRoom;
    beforeEach(async () => {
        await DatabaseManager.clearData();
        await DatabaseManager.insertData();

        report1 = new ReportedRoom();
        report1.reportId = 1;
        report1.reportContent = "reportContent";

        //report1 = await ReportedRoom.repo.save(report1);
    });



    it('should return null if reportedRoom is not found', async () => {
        const result = await ReportedRoom.repo.findOne(1000);
        expect(result).toBeUndefined();
    });

    it('should return true if reportedRoom name is found', async () => {
        const result = await ReportedRoom.repo.find({reportId: report1.reportId});
        expect(result).toBeTruthy();
    });

    it('should return false if reportedRoom reportContent is not found', async () => {
        const result = await ReportedRoom.repo.findOne({reportContent: "not a reportedRoom name"});
        expect(result).toBeFalsy();
    });

    it('should return right object after it was inserted', async () => {
        const duplicatedReview = new ReportedRoom();
        //duplicatedReview.roomGroupId = roomGroup1.id;
        duplicatedReview.reportContent = "name";

        await ReportedRoom.repo.save(duplicatedReview);

        const result = await ReportedRoom.repo.find({reportContent: duplicatedReview.reportContent});
        expect(result).toBeTruthy();
    });

    it('should return right object after it was updated', async () => {
        const duplicatedReview = new ReportedRoom();
        duplicatedReview.reportId = 3;
        //duplicatedReview.roomGroupId = roomGroup1.id;
        duplicatedReview.reportContent = "name";

        await ReportedRoom.repo.save(duplicatedReview);

        let updateReview = duplicatedReview;
        updateReview.reportContent = 'update name';
        await ReportedRoom.repo.updateById(duplicatedReview.reportId, updateReview);

        const result = await ReportedRoom.repo.findOne({reportId: duplicatedReview.reportId});
        expect(result.reportContent).toBe(updateReview.reportContent);
    });

    it('should return null object after it was deleted', async () => {
        const duplicatedReview = new ReportedRoom();
        duplicatedReview.reportId = 3;
        //duplicatedReview.roomGroupId = roomGroup1.id;
        duplicatedReview.reportContent = "name";

        await ReportedRoom.repo.save(duplicatedReview);
        await ReportedRoom.repo.delete(duplicatedReview.reportId);

        const result = await ReportedRoom.repo.findOne({reportId: duplicatedReview.reportId});
        expect(result).toBeUndefined();
    });

});
