import {
  BaseEntity,
  Column,
  Entity,
  EntityRepository, getCustomRepository,
  Repository,
  PrimaryColumn, ManyToOne, JoinColumn, OneToMany, Not, LessThan, getConnection,
} from 'typeorm';
import { ConstantValues } from '../utils/constant-values';
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
    name: Room.schema.createdAt,
  })
  createdAt: Date;

  @Column({
    type: 'timestamp',
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
  async updateById(roomId: any, roomUpdate: any) {
    let room = await this.findOne(roomId);
    if (room) {
      room.roomName = roomUpdate.roomName ? roomUpdate.roomName : room.roomName;
      room.roomStatus = roomUpdate.roomStatus ? roomUpdate.roomStatus : room.roomStatus;
      await this.save(room);
    }
    return room;
  }

  async createMultipleRooms(values: any, roomGroupId: number) {
    await this.createQueryBuilder('room')
      .insert()
      .into(Room)
      .values(values)
      .execute();
    return await this.getRoomsByRoomGroupId(roomGroupId);
  }

  async getRoomsByRoomGroupId(roomGroupId: number) {
    return await this.createQueryBuilder('room')
      .select(['room.roomId', 'room.roomGroupId', 'room.roomName', 'room.roomStatus'])
      .where('room.room_group_id = :roomGroupId', { roomGroupId })
      .andWhere('room.room_status <> :roomStatus', { roomStatus: ConstantValues.ROOM_WAS_DELETED })
      .getMany();
  }

  async getAvailableRoomsInGroup(roomGroupId: any) {
    return await getConnection()
      .createQueryBuilder()
      .select(['room.roomId', 'room.roomName'])
      .from(Room, 'room')
      .where('room.room_group_id = :roomGroupId', { roomGroupId: roomGroupId })
      .andWhere('room.room_status <> :notAvailable', { notAvailable: ConstantValues.ROOM_NOT_AVAILABLE })
      .getMany();
  }
}
