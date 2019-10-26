import {
  BaseEntity,
  Column,
  Entity,
  EntityRepository,
  getCustomRepository,
  getManager,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryColumn,
  Repository,
} from 'typeorm';
import { Building } from './building';
import { Room } from './room';
import { RoomAmenities } from './room-amenities';
import { Length } from 'class-validator';
import { RoomImage } from './room-image';
import { BuildingService } from './building-service';
import { User } from './user';

@Entity(RoomGroup.tableName)
export class RoomGroup extends BaseEntity {
  static readonly tableName = 'room_group';
  static readonly schema = {
    id: 'room_group_id',
    buildingId: 'building_id',
    gender: 'gender',
    rentPrice: 'rent_price',
    area: 'area',
    bedroomQuantity: 'bedroom_quantity',
    bathroomQuantity: 'bathroom_quantity',
    wcQuantity: 'wc_quantity',
    direction: 'direction',
    isAvailable: 'is_available',
    isVerified: 'is_verified',
    depositPrice: 'deposit_price',
    description: 'description',
    capacity: 'capacity',
    quantity: 'quantity',
    viewAmount: 'view_amount',
    phoneViewAmount: 'phone_view_amount',
    isSponsored: 'is_sponsored',
    createdAt: 'created_at',
    updatedAt: 'updated_at',
  };

  @PrimaryColumn({
    type: 'int',
    generated: true,
    unsigned: true,
    name: RoomGroup.schema.id,
  })
  id: number;

  @ManyToOne(type => Building, building => building.roomGroups)
  @JoinColumn({ name: RoomGroup.schema.buildingId })
  building: Building;
  @Column({ name: RoomGroup.schema.buildingId })
  buildingId: number;

  @Column({
    type: 'boolean',
    name: RoomGroup.schema.gender,
  })
  gender: boolean;

  @Column({
    type: 'double',
    name: RoomGroup.schema.rentPrice,
  })
  rentPrice: number;

  @Column({
    type: 'double',
    name: RoomGroup.schema.area,
  })
  area: number;

  @Column({
    type: 'int',
    name: RoomGroup.schema.bedroomQuantity,
  })
  bedroomQuantity: number;

  @Column({
    type: 'int',
    name: RoomGroup.schema.bathroomQuantity,
  })
  bathroomQuantity: number;

  @Column({
    type: 'int',
    name: RoomGroup.schema.wcQuantity,
  })
  wcQuantity: number;

  @Column({
    type: 'varchar',
    length: 255,
    name: RoomGroup.schema.direction,
  })
  @Length(0, 255)
  direction: string;

  @Column({
    type: 'boolean',
    name: RoomGroup.schema.isAvailable,
  })
  isAvailable: boolean;

  @Column({
    type: 'boolean',
    name: RoomGroup.schema.isVerified,
  })
  isVerified: boolean;


  @Column({
    type: 'double',
    name: RoomGroup.schema.depositPrice,
  })
  depositPrice: number;

  @Column({
    type: 'text',
    name: RoomGroup.schema.description,
  })
  description: string;

  @Column({
    type: 'int',
    name: RoomGroup.schema.capacity,
  })
  capacity: number;

  @Column({
    type: 'int',
    unique: false,
    name: RoomGroup.schema.viewAmount,
  })
  viewAmount: number;

  @Column({
    type: 'int',
    unique: false,
    name: RoomGroup.schema.phoneViewAmount,
  })
  phoneViewAmount: number;

  @Column({
    type: 'bit',
    unique: false,
    name: RoomGroup.schema.isSponsored,
  })
  isSponsored: boolean;

  @Column({
    type: 'timestamp',
    precision: 6,
    default: () => 'CURRENT_TIMESTAMP(6)',
    onUpdate: 'CURRENT_TIMESTAMP(6)',
    name: RoomGroup.schema.createdAt,
  })
  createdAt: Date;

  @Column({
    type: 'timestamp',
    precision: 6,
    default: () => 'CURRENT_TIMESTAMP(6)',
    onUpdate: 'CURRENT_TIMESTAMP(6)',
    name: RoomGroup.schema.updatedAt,
  })
  updatedAt: Date;

  @OneToMany(type => Room, room => room.roomGroup)
  @JoinColumn({ name: RoomGroup.schema.id })
  rooms: Room[];

  @OneToMany(type => RoomAmenities, roomAmenities => roomAmenities.roomGroup)
  @JoinColumn({ name: RoomGroup.schema.id })
  roomAmenities: RoomAmenities[];

  @OneToMany(type => RoomImage, roomImage => roomImage.roomGroup)
  @JoinColumn({ name: RoomGroup.schema.id })
  roomImages: RoomImage[];


  static get repo(): RoomGroupRepository {
    return getCustomRepository(RoomGroupRepository);
  }
}

@EntityRepository(RoomGroup)
export class RoomGroupRepository extends Repository<RoomGroup> {
  async updateById(roomGroupId: any, roomGroupUpdate: RoomGroup) {
    let roomGroup = await this.findOne(roomGroupId);
    if (roomGroup) {
      roomGroup.gender = roomGroupUpdate.gender ? roomGroupUpdate.gender : roomGroup.gender;
      roomGroup.rentPrice = roomGroupUpdate.rentPrice ? roomGroupUpdate.rentPrice : roomGroup.rentPrice;
      roomGroup.area = roomGroupUpdate.area ? roomGroupUpdate.area : roomGroup.area;
      roomGroup.bedroomQuantity = roomGroupUpdate.bedroomQuantity ? roomGroupUpdate.bedroomQuantity : roomGroup.bedroomQuantity;
      roomGroup.bathroomQuantity = roomGroupUpdate.bathroomQuantity ? roomGroupUpdate.bathroomQuantity : roomGroup.bathroomQuantity;
      roomGroup.wcQuantity = roomGroupUpdate.wcQuantity ? roomGroupUpdate.wcQuantity : roomGroup.wcQuantity;
      roomGroup.direction = roomGroupUpdate.direction ? roomGroupUpdate.direction : roomGroup.direction;
      roomGroup.isAvailable = roomGroupUpdate.isAvailable ? roomGroupUpdate.isAvailable : roomGroup.isAvailable;
      roomGroup.isVerified = roomGroupUpdate.isVerified ? roomGroupUpdate.isVerified : roomGroup.isVerified;
      roomGroup.depositPrice = roomGroupUpdate.depositPrice ? roomGroupUpdate.depositPrice : roomGroup.depositPrice;
      roomGroup.description = roomGroupUpdate.description ? roomGroupUpdate.description : roomGroup.description;
      roomGroup.capacity = roomGroupUpdate.capacity ? roomGroupUpdate.capacity : roomGroup.capacity;
      roomGroup.viewAmount = roomGroupUpdate.viewAmount ? roomGroupUpdate.viewAmount : roomGroup.viewAmount;
      roomGroup.phoneViewAmount = roomGroupUpdate.phoneViewAmount ? roomGroupUpdate.phoneViewAmount : roomGroup.phoneViewAmount;
      roomGroup.isSponsored = roomGroupUpdate.isSponsored ? roomGroupUpdate.isSponsored : roomGroup.isSponsored;
      await this.save(roomGroup);
    }
    return roomGroup;
  }

  async getImages(roomGroupId: any) {
    return await getManager()
      .createQueryBuilder(RoomImage, 'room_image')
      .select(['room_image.image_url'])
      .innerJoin(RoomGroup, 'room_group', 'room_image.room_group_id = room_group.room_group_id')
      .where('room_image.room_group_id = :room_group_id', { room_group_id: roomGroupId })
      .getRawMany();
  }

  async getRoomGroupDetail(roomGroupId: any, roomGroup: any) {
    const building = await Building.repo.findOne(roomGroup.buildingId);
    const amenities = await RoomAmenities.repo.getAmenitiesDetailRoomGroup(roomGroupId);
    const amenitiesNot = await RoomAmenities.repo.getAmenitiesDetailNotInRoomGroup(roomGroupId);
    let amenitiesConcat = [];
    for (let i = 0; i < amenitiesNot.length; i++) {
      if ((amenitiesNot[i].amenities_name != null) && (amenitiesNot[i].amenities_name.length > 0)) {
        let temp = [amenitiesNot[i]];
        amenitiesConcat = amenitiesConcat.concat(temp);
      }
    }
    const totalAmenities = amenities.concat(amenitiesConcat);
    const services = await BuildingService.repo.getServiceDetailBuilding(roomGroup.buildingId);
    const phone = await User.repo.getHostPhone(building.hostId);
    const images = await this.getImages(roomGroupId);
    let imageLinks = [];
    images.forEach(function(element) {
      let temp = [element.image_url];
      imageLinks = imageLinks.concat(temp);
    });

    return {
      images: imageLinks,
      title: building.buildingName + ' ' + building.province + ' ' + `${building.street ? building.street : ''}`,
      generalAddress: {
        province: building.province,
        district: building.district,
        ward: building.ward,
      },
      status: (roomGroup.quantity > 0) ? 'Còn phòng' : 'Không còn phòng',
      area: roomGroup.area,
      capacity: roomGroup.capacity,
      gender: (roomGroup.gender == true) ? 'Nam' : 'Nữ',
      amenities: totalAmenities,
      description: roomGroup.description,
      roomCost: {
        price: roomGroup.rentPrice,
        deposit: roomGroup.depositPrice,
      },
      services: services,
      phone: phone,
    };
  }
}
