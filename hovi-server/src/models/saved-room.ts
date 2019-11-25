import {
    BaseEntity,
    Column,
    Entity,
    EntityRepository,
    getConnection,
    getCustomRepository,
    getManager,
    getRepository,
    JoinColumn,
    ManyToOne,
    PrimaryColumn,
    Repository,
} from 'typeorm';
import { RoomGroup } from './room-group';
import { User } from './user';

@Entity(SavedRoom.tableName)
export class SavedRoom extends BaseEntity {
    static readonly tableName = 'saved_room';
    static readonly schema = {
        roomGroupId: 'room_group_id',
        userId: 'user_id',
        createAt: 'created_at',
        updateAt: 'updated_at',
    };


    @ManyToOne(type => RoomGroup, roomGroup => roomGroup.savedRooms)
    @JoinColumn({ name: SavedRoom.schema.roomGroupId })
    roomGroup: RoomGroup;
    @PrimaryColumn({ name: SavedRoom.schema.roomGroupId })
    roomGroupId: number;


    @ManyToOne(type => User, user => user.savedRooms)
    @JoinColumn({ name: SavedRoom.schema.userId })
    user: User;
    @PrimaryColumn({ name: SavedRoom.schema.userId })
    userId: number;

    @Column({
        type: 'timestamp',
        name: SavedRoom.schema.createAt,
    })
    createAt: Date;

    @Column({
        type: 'timestamp',
        name: SavedRoom.schema.updateAt,
    })
    updateAt: Date;


    static get repo(): SavedRoomRepository {
        return getCustomRepository(SavedRoomRepository);
    }
}

@EntityRepository(SavedRoom)
export class SavedRoomRepository extends Repository<SavedRoom> {
    async updateById(roomGroupId: any, userId: any, savedRoomUpdate: SavedRoom) {
        let savedRoom = await this.getOneRecord(roomGroupId, userId);
        if (savedRoom) {
            savedRoom.roomGroupId = savedRoomUpdate.roomGroupId ? savedRoomUpdate.roomGroupId : savedRoom.roomGroupId;
            savedRoom.userId = savedRoomUpdate.userId ? savedRoomUpdate.userId : savedRoom.userId;
            savedRoom.createAt = savedRoomUpdate.createAt ? savedRoomUpdate.createAt : savedRoom.createAt;
            savedRoom.updateAt = savedRoomUpdate.updateAt ? savedRoomUpdate.updateAt : savedRoom.updateAt;
            await this.save(savedRoom);
        }
        return savedRoom;
    }

    async getUserInRoomGroup(roomGroupId: any) {
        return await getRepository(RoomGroup)
            .createQueryBuilder('roomGroup')
            .select(['roomGroup.id', 'savedRoom.userId', 'savedRoom.roomGroupId'])
            .where('savedRoom.roomGroupId = :roomGroupId', { roomGroupId: roomGroupId })
            .innerJoin('roomGroup.savedRoom', 'savedRoom')
            .getMany();
    }

    async getOneRecord(roomGroupId: any, userId: any) {
        return await getRepository(SavedRoom)
            .createQueryBuilder('savedRoom')
            .where('room_group_id = :roomGroupId', { roomGroupId: roomGroupId })
            .andWhere('savedRoom.userId = :userId', { userId: userId })
            .getOne();
    }

    async deleteOneRecord(roomGroupId: any, userId: any) {
        return await getConnection()
            .createQueryBuilder()
            .delete()
            .from(SavedRoom)
            .where('roomGroupId = :roomGroupId', { roomGroupId: roomGroupId })
            .andWhere('userId = :userId', { userId: userId })
            .execute();
    }

    async getUserDetailRoomGroup(roomGroupId: any) {
        return await getManager()
            .createQueryBuilder(SavedRoom, 'room_user')
            .select(['room_user.user_id', 'user.icon_id', 'user.usable_name as user_name'])
            .innerJoin(RoomGroup, 'room_group', 'room_group.room_group_id = room_user.room_group_id')
            .innerJoin(User, 'user', 'room_user.user_id = user.user_id')
            .where('room_user.room_group_id = :room_group_id', { room_group_id: roomGroupId })
            .getRawMany();
    }

    async getUserDetailNotInRoomGroup(roomGroupId: any) {
        const userNot = await this.manager.query("SELECT user.user_id, user.icon_id, user.unusable_name as \'user_name\' FROM user where user.user_id\n" +
            "NOT IN (select room_user.user_id from room_user INNER JOIN room_group on room_user.room_group_id = room_group.room_group_id WHERE room_group.room_group_id = ?)",
            [roomGroupId]);
        return userNot;
    }
}

