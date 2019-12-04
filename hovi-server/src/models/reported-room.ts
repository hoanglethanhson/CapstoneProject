import {
    BaseEntity,
    Column,
    Entity,
    EntityRepository,
    getCustomRepository,
    Repository,
    PrimaryColumn,
    ManyToOne,
    JoinColumn,
    CreateDateColumn,
    UpdateDateColumn, getManager
} from 'typeorm';
import {User} from "./user";
import {RoomGroup} from "./room-group";

@Entity(ReportedRoom.tableName)
export class ReportedRoom extends BaseEntity {
    static readonly tableName = 'reported_room';
    static readonly schema = {
        reportId: 'report_id',
        userId: 'user_id',
        roomGroupId: 'room_group_id',
        reportContent: 'report_content',
        createAt: 'created_at',
        updateAt: 'updated_at'
    };

    @PrimaryColumn({
        type: "int",
        generated: true,
        unsigned: true,
        name: ReportedRoom.schema.reportId
    })
    reportId: number;

    @ManyToOne(type => User, user => user.reportedRooms)
    @JoinColumn({name: ReportedRoom.schema.userId})
    user: User;
    @Column({name: ReportedRoom.schema.userId})
    userId: number;


    @ManyToOne(type => RoomGroup, roomGroup => roomGroup.reportedRooms)
    @JoinColumn({name: ReportedRoom.schema.roomGroupId})
    roomGroup: RoomGroup;
    @Column({name: ReportedRoom.schema.roomGroupId})
    roomGroupId: number;

    @Column({
        type: "text",
        unique: false,
        name: ReportedRoom.schema.reportContent
    })
    reportContent: string;

    @CreateDateColumn({
        type: "timestamp",
        name: ReportedRoom.schema.createAt
    })
    createAt: Date;

    @UpdateDateColumn({
        type: "timestamp",
        name: ReportedRoom.schema.updateAt
    })
    updateAt: Date;


    static get repo(): ReportedRoomRepository {
        return getCustomRepository(ReportedRoomRepository);
    }
}

@EntityRepository(ReportedRoom)
export class ReportedRoomRepository extends Repository<ReportedRoom> {
    async updateById(reportedRoomId: any, reportedRoomUpdate: ReportedRoom) {
        let reportedRoom = await this.findOne(reportedRoomId);
        if (reportedRoom) {
            reportedRoom.userId = reportedRoomUpdate.userId ? reportedRoomUpdate.userId : reportedRoom.userId;
            reportedRoom.roomGroupId = reportedRoomUpdate.roomGroupId ? reportedRoomUpdate.roomGroupId : reportedRoom.roomGroupId;
            reportedRoom.reportContent = reportedRoomUpdate.reportContent ? reportedRoomUpdate.reportContent : reportedRoom.reportContent;
            reportedRoom.createAt = reportedRoomUpdate.createAt ? reportedRoomUpdate.createAt : reportedRoom.createAt;
            reportedRoom.updateAt = reportedRoomUpdate.updateAt ? reportedRoomUpdate.updateAt : reportedRoom.updateAt;
            await this.save(reportedRoom);
        }
        return reportedRoom;
    }

}
