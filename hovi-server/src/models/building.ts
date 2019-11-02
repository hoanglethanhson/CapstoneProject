import {
  BaseEntity,
  Column,
  Entity,
  EntityRepository, getCustomRepository,
  Repository,
  PrimaryColumn, ManyToOne, JoinColumn, OneToMany, getRepository,
} from 'typeorm';
import { RoomType } from './building-type';
import { User } from './user';
import { RoomGroup } from './room-group';
import { BuildingService } from './building-service';
import { ConstantValues } from '../utils/constant-values';

@Entity(Building.tableName)
export class Building extends BaseEntity {
  static readonly tableName = 'building';
  static readonly schema = {
    id: 'building_id',
    buildingName: 'building_name',
    typeId: 'building_type_id',
    province: 'province',
    district: 'district',
    ward: 'ward',
    detailedAddress: 'detailed_address',
    addressDescription: 'address_description',
    location: 'location',
    floorQuantity: 'floor_quantity',
    hostId: 'host_id',
    isVerified: 'is_verified',
    isCompleted: 'is_completed',
    createdAt: 'created_at',
    updatedAt: 'updated_at',
  };

  @PrimaryColumn({
    type: 'int',
    generated: true,
    unsigned: true,
    name: Building.schema.id,
  })
  id: number;

  @Column({
    type: 'varchar',
    length: 255,
    default: 'default value',
    name: Building.schema.buildingName,
  })
  buildingName: string;

  @ManyToOne(type => RoomType, roomType => roomType.buildings)
  @JoinColumn({ name: Building.schema.typeId })
  roomType: RoomType;
  @Column({ name: Building.schema.typeId })
  typeId: number;

  @ManyToOne(type => User, user => user.buildings)
  @JoinColumn({ name: Building.schema.hostId })
  host: User;
  @Column({ name: Building.schema.hostId })
  hostId: number;

  @Column({
    type: 'varchar',
    length: 255,
    default: 'default value',
    name: Building.schema.province,
  })
    //@Length(0, 255)
  province: string;

  @Column({
    type: 'varchar',
    length: 255,
    default: 'default value',
    name: Building.schema.district,
  })
  district: string;

  @Column({
    type: 'varchar',
    length: 255,
    default: 'default value',
    name: Building.schema.ward,
  })
  ward: string;

  @Column({
    type: 'varchar',
    length: 255,
    default: 'default value',
    name: Building.schema.detailedAddress,
  })
  detailedAddress: string;

  @Column({
    type: 'varchar',
    length: 255,
    default: 'default value',
    name: Building.schema.addressDescription,
  })
  addressDescription: string;

  @Column({
    type: 'text',
    default: 'default value',
    name: Building.schema.location,
  })
  location: string;

  @Column({
    type: 'int',
    name: Building.schema.floorQuantity,
  })
  floorQuantity: number;

  @Column({
    type: 'boolean',
    name: Building.schema.isVerified,
  })
  isVerified: boolean;

  @Column({
    type: 'int',
    name: Building.schema.isCompleted,
  })
  isCompleted: number;

  @Column({
    type: 'timestamp',
    precision: 6,
    default: () => 'CURRENT_TIMESTAMP(6)',
    onUpdate: 'CURRENT_TIMESTAMP(6)',
    name: Building.schema.createdAt,
  })
  create: Date;

  @Column({
    type: 'timestamp',
    precision: 6,
    default: () => 'CURRENT_TIMESTAMP(6)',
    onUpdate: 'CURRENT_TIMESTAMP(6)',
    name: Building.schema.updatedAt,
  })
  update: Date;

  @OneToMany(type => RoomGroup, roomGroup => roomGroup.building)
  @JoinColumn({ name: Building.schema.id })
  roomGroups: RoomGroup[];

  @OneToMany(type => BuildingService, buildingService => buildingService.building)
  @JoinColumn({ name: Building.schema.id })
  buildingServices: BuildingService[];

  static get repo(): BuildingRepository {
    return getCustomRepository(BuildingRepository);
  }
}

@EntityRepository(Building)
export class BuildingRepository extends Repository<Building> {
  async updateById(buildingId: any, buildingUpdate: Building) {
    let building = await this.findOne(buildingId);
    if (building) {
      building.typeId = buildingUpdate.typeId ? buildingUpdate.typeId : building.typeId;
      building.buildingName = buildingUpdate.buildingName ? buildingUpdate.buildingName : building.buildingName;
      building.province = buildingUpdate.province ? buildingUpdate.province : building.province;
      building.district = buildingUpdate.district ? buildingUpdate.district : building.district;
      building.ward = buildingUpdate.ward ? buildingUpdate.ward : building.ward;
      building.detailedAddress = buildingUpdate.detailedAddress ? buildingUpdate.detailedAddress : building.detailedAddress;
      building.location = buildingUpdate.location ? buildingUpdate.location : building.location;
      building.floorQuantity = buildingUpdate.floorQuantity ? buildingUpdate.floorQuantity : building.floorQuantity;
      building.isVerified = buildingUpdate.isVerified ? buildingUpdate.isVerified : building.isVerified;
      await this.save(building);
    }
    return building;
  }

  async getBuildingInformation(typeId: number, hostId: number) {
    return this.createQueryBuilder('building')
      .leftJoinAndSelect('building.roomGroups', 'roomGroup')
      .leftJoinAndSelect('building.buildingServices', 'buildingService')
      .leftJoinAndSelect('roomGroup.rooms', 'room')
      .leftJoinAndSelect('roomGroup.roomAmenities', 'roomAmenities')
      .leftJoinAndSelect('roomGroup.roomImages', 'roomImages')
      .where('building.typeId = :typeId', { typeId })
      .andWhere('building.hostId = :hostId', { hostId })
      .andWhere('room.room_status <> :roomStatus', { roomStatus: ConstantValues.ROOM_WAS_DELETED })
      .getMany();
  }

  async updateStatus(buildingId: number, isComplete: number) {
    //update isComplete by buildingId
    const building = await Building.repo.findOne(buildingId);
    //set isComplete and save
    building.isCompleted = isComplete;
    await this.save(building);
    return building;
  }


}
