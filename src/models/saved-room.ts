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
}

