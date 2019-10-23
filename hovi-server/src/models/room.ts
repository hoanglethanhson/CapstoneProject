import {
  BaseEntity,
  Column,
  Entity,
  EntityRepository, getCustomRepository,
  Repository,
  PrimaryColumn, ManyToOne, JoinColumn, OneToMany, getManager, getRepository, getConnection,
} from 'typeorm';
import { RoomGroup } from './room-group';
import { Transaction } from './transaction';

@Entity(Room.tableName)
export class Room extends BaseEntity {
  static readonly tableName = 'room';
  static readonly schema = {
    roomId: 'room_id',
    roomGroupId: 'room_group_id',
    roomName: 'room_name',
    roomStatus: 'room_status',
    createdAt: 'created_at',
    updatedAt: 'updated_at',
  };

  @PrimaryColumn({
    type: 'int',
    generated: true,
    unsigned: true,
    name: Room.schema.roomId,
  })
  roomId: number;

  @ManyToOne(type => RoomGroup, roomGroup => roomGroup.rooms)
  @JoinColumn({ name: Room.schema.roomGroupId })
  roomGroup: RoomGroup;
  @Column({ name: Room.schema.roomGroupId })
  roomGroupId: number;


  @Column({
    type: 'text',
    unique: false,
    name: Room.schema.roomName,
  })
  roomName: string;

  @Column({
    type: 'tinyint',
    unique: false,
    name: Room.schema.roomStatus,
  })
  roomStatus: number;

  @Column({
    type: 'timestamp',
    precision: 6,
    default: () => 'CURRENT_TIMESTAMP(6)',
    onUpdate: 'CURRENT_TIMESTAMP(6)',
    name: Room.schema.createdAt,
  })
  createdAt: Date;

  @Column({
    type: 'timestamp',
    precision: 6,
    default: () => 'CURRENT_TIMESTAMP(6)',
    onUpdate: 'CURRENT_TIMESTAMP(6)',
    name: Room.schema.updatedAt,
  })
  updatedAt: Date;


  @OneToMany(type => Transaction, transaction => transaction.room)
  @JoinColumn({ name: Room.schema.roomId })
  transactions: Transaction[];

  static get repo(): RoomRepository {
    return getCustomRepository(RoomRepository);
  }
}

@EntityRepository(Room)
export class RoomRepository extends Repository<Room> {
  async updateById(roomId: any, roomUpdate: Room) {
    let room = await this.findOne(roomId);
    if (room) {
      room.roomGroupId = roomUpdate.roomGroupId ? roomUpdate.roomGroupId : room.roomGroupId;
      room.roomName = roomUpdate.roomName ? roomUpdate.roomName : room.roomName;
      await this.save(room);
    }
    return room;
  }

  async createMultipleRooms(values: any) {
    return await this.createQueryBuilder('room')
      .insert()
      .into(Room)
      .values(values)
      .execute();
  }

  async getAvailableRoomsInGroup(roomGroupId: any) {
    return await getConnection()
        .createQueryBuilder()
        .select(["room.roomId", "room.roomName"])
        .from(Room, "room")
        .where("room.room_group_id = :roomGroupId", {roomGroupId: roomGroupId})
        .andWhere("room.room_status <> :notAvailable", {notAvailable: 0})
        .getMany();
  }
}
