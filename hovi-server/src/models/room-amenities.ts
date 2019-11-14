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
import { Amenities } from './amenities';

@Entity(RoomAmenities.tableName)
export class RoomAmenities extends BaseEntity {
  static readonly tableName = 'room_amenities';
  static readonly schema = {
    roomGroupId: 'room_group_id',
    amenitiesId: 'amenities_id',
    usableName: 'usable_name',
    unsuableName: 'unsuable_name',
    description: 'description',
    createAt: 'created_at',
    updateAt: 'updated_at',
  };


  @ManyToOne(type => RoomGroup, roomGroup => roomGroup.roomAmenities)
  @JoinColumn({ name: RoomAmenities.schema.roomGroupId })
  roomGroup: RoomGroup;
  @PrimaryColumn({ name: RoomAmenities.schema.roomGroupId })
  roomGroupId: number;


  @ManyToOne(type => Amenities, amenities => amenities.roomAmenities)
  @JoinColumn({ name: RoomAmenities.schema.amenitiesId })
  amenities: Amenities;
  @PrimaryColumn({ name: RoomAmenities.schema.amenitiesId })
  amenitiesId: number;

  @Column({
    type: 'timestamp',
    name: RoomAmenities.schema.createAt,
  })
  createAt: Date;

  @Column({
    type: 'timestamp',
    name: RoomAmenities.schema.updateAt,
  })
  updateAt: Date;


  static get repo(): RoomAmenitiesRepository {
    return getCustomRepository(RoomAmenitiesRepository);
  }
}

@EntityRepository(RoomAmenities)
export class RoomAmenitiesRepository extends Repository<RoomAmenities> {
  async updateById(roomGroupId: any, amenitiesId: any, roomAmenitiesUpdate: RoomAmenities) {
    let roomAmenities = await this.getOneRecord(roomGroupId, amenitiesId);
    if (roomAmenities) {
      roomAmenities.roomGroupId = roomAmenitiesUpdate.roomGroupId ? roomAmenitiesUpdate.roomGroupId : roomAmenities.roomGroupId;
      roomAmenities.amenitiesId = roomAmenitiesUpdate.amenitiesId ? roomAmenitiesUpdate.amenitiesId : roomAmenities.amenitiesId;
      roomAmenities.createAt = roomAmenitiesUpdate.createAt ? roomAmenitiesUpdate.createAt : roomAmenities.createAt;
      roomAmenities.updateAt = roomAmenitiesUpdate.updateAt ? roomAmenitiesUpdate.updateAt : roomAmenities.updateAt;
      await this.save(roomAmenities);
    }
    return roomAmenities;
  }

  async getAmenitiesInRoomGroup(roomGroupId: any) {
    return await getRepository(RoomGroup)
      .createQueryBuilder('roomGroup')
      .select(['roomGroup.id', 'roomAmenities.amenitiesId', 'roomAmenities.roomGroupId'])
      .where('roomAmenities.roomGroupId = :roomGroupId', { roomGroupId: roomGroupId })
      .innerJoin('roomGroup.roomAmenities', 'roomAmenities')
      .getMany();
  }

  async getOneRecord(roomGroupId: any, amenitiesId: any) {
    return await getRepository(RoomAmenities)
      .createQueryBuilder('roomAmenities')
      .where('room_group_id = :roomGroupId', { roomGroupId: roomGroupId })
      .andWhere('roomAmenities.amenitiesId = :amenitiesId', { amenitiesId: amenitiesId })
      .getOne();
  }

  async deleteOneRecord(roomGroupId: any, amenitiesId: any) {
    return await getConnection()
      .createQueryBuilder()
      .delete()
      .from(RoomAmenities)
      .where('roomGroupId = :roomGroupId', { roomGroupId: roomGroupId })
      .andWhere('amenitiesId = :amenitiesId', { amenitiesId: amenitiesId })
      .execute();
  }

  async getAmenitiesDetailRoomGroup(roomGroupId: any) {
    return await getManager()
      .createQueryBuilder(RoomAmenities, 'room_amenities')
      .select(['room_amenities.amenities_id', 'amenities.icon_id', 'amenities.usable_name as amenities_name'])
      .innerJoin(RoomGroup, 'room_group', 'room_group.room_group_id = room_amenities.room_group_id')
      .innerJoin(Amenities, 'amenities', 'room_amenities.amenities_id = amenities.amenities_id')
      .where('room_amenities.room_group_id = :room_group_id', { room_group_id: roomGroupId })
      .getRawMany();
  }

  async getAmenitiesDetailNotInRoomGroup(roomGroupId: any) {
    const amenitiesNot = await this.manager.query("SELECT amenities.amenities_id, amenities.icon_id, amenities.unusable_name as \'amenities_name\' FROM amenities where amenities.amenities_id\n" +
        "NOT IN (select room_amenities.amenities_id from room_amenities INNER JOIN room_group on room_amenities.room_group_id = room_group.room_group_id WHERE room_group.room_group_id = ?)",
        [roomGroupId]);
    return amenitiesNot;
  }
}

