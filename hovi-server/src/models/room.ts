import {
  BaseEntity,
  Column,
  Entity,
  EntityRepository, getCustomRepository,
  Repository,
  PrimaryColumn, ManyToOne, JoinColumn, OneToMany, Not, LessThan, getConnection, getManager,
} from 'typeorm';
import { ConstantValues } from '../utils/constant-values';
import { RoomGroup } from './room-group';
import { Transaction } from './transaction';
import {User} from "./user";
import {Building} from "./building";
import {RoomImage} from "./room-image";

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
      room.roomName = roomUpdate.roomName;
      room.roomStatus = roomUpdate.roomStatus;
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

  async getManagementRooms(userId: any, keySent: any) {
    let rawResult;
    let result = [];
    if (keySent.length == 1) {
        const typeId = parseInt(keySent);
        rawResult = await getManager()
            .createQueryBuilder(Room, 'room')
            .select(['*'])
            .innerJoin(RoomGroup, 'room_group', 'room.room_group_id = room_group.room_group_id')
            //.innerJoin(RoomImage, 'room_image', 'room_image.room_group_id = room_group.room_group_id')
            .innerJoin(Building, 'building', 'room_group.building_id = building.building_id')
            .leftJoin(Transaction, 'transaction', 'room.room_id = transaction.room_id')
            .leftJoin(User, 'user', 'transaction.user_id = user.user_id')
            .where('building.building_type_id = :type_id', {type_id: typeId})
            .andWhere('building.host_id = :user_id', {user_id: userId})
            .getRawMany();
    } else {
      const buildingId = parseInt(keySent.split('-')[1].trim());
      rawResult = await getManager()
          .createQueryBuilder(Room, 'room')
          .select(['*'])
          .leftJoin(Transaction, 'transaction', 'room.room_id = transaction.room_id')
          .innerJoin(User, 'user', 'transaction.user_id = user.user_id')
          .innerJoin(RoomGroup, 'room_group', 'room.room_group_id = room_group.room_group_id')
          .innerJoin(RoomImage, 'room_image', 'room_image.room_group_id = room_group.room_group_id')
          .innerJoin(Building, 'building', 'room_group.building_id = building.building_id')
          .where('building.building_id = :building_id', {building_id: buildingId})
          .andWhere('building.host_id = :user_id', {user_id: userId})
          .getRawMany();
    }
    for (const record of rawResult) {
      const transaction = await Transaction.repo.findOne(record.transaction_id);
      const tenant = await User.repo.findOne(transaction.userId);
      const roomImage = await RoomImage.repo.find({roomGroupId: record.room_group_id});
      const room = await Room.repo.findOne({roomName: record.room_name, roomGroupId: record.room_group_id})
      //console.log(roomImage[0].imageUrl);
      const resultRecord = {
        title: record.building_name,
        address: record.province + record.district + record.ward,
        image: (roomImage.length > 0)? roomImage[0].imageUrl: null,
        price: record.rent_price,
        deposit: record.deposit_price,
        status: (record.transaction_status)? record.transaction_status : 0,
        transactionId: (record.transaction_id != ConstantValues.DUMMY_STATUS
                        && record.transaction_id != ConstantValues.HOST_REJECTED)? record.transaction_id : null,
        tenant: (record.transaction_id != null) ? {
          userId: tenant.id,
          userName: tenant.firstName + " " + tenant.lastName,
          phoneNumber: tenant.phoneNumber
        } : null,
        roomId: room.roomId,
        roomName: room.roomName,
        roomGroupId: record.room_group_id,
        buildingId: record.building_id,
        buildingTypeId: record.building_type_id
      }
      result.push(resultRecord);
    }
    return result;
  }
}
