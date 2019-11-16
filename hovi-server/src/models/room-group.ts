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

import {buildingTitle} from '../utils';
import {Building} from './building';
import {Room} from './room';
import {RoomAmenities} from './room-amenities';
import {IsNumber, Length, Min, IsIn} from 'class-validator';
import {RoomImage} from './room-image';
import {BuildingService} from './building-service';
import {User} from './user';
import {TenantReview} from './tenant-review';
import {ConstantValues} from '../utils/constant-values';
import {RoomType} from "./building-type";
import {Transaction} from "./transaction";


@Entity(RoomGroup.tableName)
export class RoomGroup extends BaseEntity {
  static readonly tableName = 'room_group';
  static readonly schema = {
    id: 'room_group_id',
    buildingId: 'building_id',
    gender: 'gender',
    rentPrice: 'rent_price',
    minDepositPeriod: 'min_deposit_period',
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
    unique: false,
    name: RoomGroup.schema.gender,
  })
  gender: boolean;

  @Column({
    type: 'double',
    unique: false,
    name: RoomGroup.schema.rentPrice,
  })
  @IsNumber()
  @Min(0)
  rentPrice: number;

  @Column({
    type: 'int',
    unique: false,
    name: RoomGroup.schema.minDepositPeriod,
  })
  @IsNumber()
  @Min(0)
  minDepositPeriod: number;

  @Column({
    type: 'double',
    unique: false,
    name: RoomGroup.schema.area,
  })
  @IsNumber()
  @Min(0)
  area: number;

  @Column({
    type: 'int',
    name: RoomGroup.schema.bedroomQuantity,
  })
  @IsNumber()
  @Min(1)
  bedroomQuantity: number;

  @Column({
    type: 'int',
    name: RoomGroup.schema.bathroomQuantity,
  })
  @IsNumber()
  @Min(1)
  bathroomQuantity: number;

  @Column({
    type: 'int',
    name: RoomGroup.schema.wcQuantity,
  })
  @IsNumber()
  @Min(1)
  wcQuantity: number;

  @Column({
    type: 'varchar',
    length: 255,
    name: RoomGroup.schema.direction,
  })
  @IsIn(ConstantValues.DIRECTION)
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
  @IsNumber()
  @Min(0)
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
  @IsNumber()
  @Min(1)
  capacity: number;

  @Column({
    type: 'int',
    unique: false,
    name: RoomGroup.schema.viewAmount,
  })
  @IsNumber()
  @Min(0)
  viewAmount: number;

  @Column({
    type: 'int',
    unique: false,
    name: RoomGroup.schema.phoneViewAmount,
  })
  @IsNumber()
  @Min(0)
  phoneViewAmount: number;

  @Column({
    type: 'boolean',
    unique: false,
    name: RoomGroup.schema.isSponsored,
  })
  isSponsored: boolean;

  @Column({
    type: 'timestamp',
    name: RoomGroup.schema.createdAt,
  })
  createdAt: Date;

  @Column({
    type: 'timestamp',
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

  @OneToMany(type => TenantReview, tenantReview => tenantReview.roomGroup)
  @JoinColumn({ name: RoomGroup.schema.id })
  tenantReviews: TenantReview[];


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
      roomGroup.minDepositPeriod = roomGroupUpdate.minDepositPeriod ? roomGroupUpdate.minDepositPeriod : roomGroup.minDepositPeriod;
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

  async getRoomGroupByBuildingId(buildingId: any) {
    return await this.find({
      buildingId,
    });
  }

  async getImages(roomGroupId: any) {
    return await getManager()
        .createQueryBuilder(RoomImage, 'room_image')
        .select(['room_image.image_url'])
        .innerJoin(RoomGroup, 'room_group', 'room_image.room_group_id = room_group.room_group_id')
        .where('room_image.room_group_id = :room_group_id', { room_group_id: roomGroupId })
        .getRawMany();
  }

  async getRoomGroupDetail(roomGroupId: any, roomGroup: RoomGroup) {
    if (Number.isInteger(roomGroupId)) {
      return null;
    }

    const building = await Building.repo.findOne(roomGroup.buildingId);
    if (building == null) {
      return null;
    }
    const availableRooms = await Room.repo.getAvailableRoomsInGroup(roomGroupId);
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
    //const phone = await User.repo.getHostPhone(building.hostId);
    const host = await User.repo.findOne(building.hostId);
    if (host == null) {
      return null;
    }
    const images = await this.getImages(roomGroupId);
    let imageLinks = [];
    images.forEach(function(element) {
      let temp = [element.image_url];
      imageLinks = imageLinks.concat(temp);
    });
    const rating = await TenantReview.repo.getRatingResult(roomGroupId);
    const reviewList = await TenantReview.repo.getReviewComment(roomGroupId);
    let tenantIds = [];
    let tenantAvatars = [];
    let tenantComments = [];
    for (const review of reviewList) {
      console.log(review);
      console.log(review.user_id);
      let tenant = await User.repo.findOne(review.user_id);
      tenantIds = tenantIds.concat(tenant.id);
      tenantAvatars = tenantAvatars.concat(tenant.avatar);
      tenantComments = tenantComments.concat(review.tenantReview_comment);
    }

    return {
      data: {
        buildingTypeId: building.typeId,
        roomGroupId: roomGroup.id,
        direction: roomGroup.direction,
        bedroomQuantity: roomGroup.bedroomQuantity,
        bathroomQuantity: roomGroup.bathroomQuantity,
        wcQuantity: roomGroup.wcQuantity,
        minDepositPeriod: roomGroup.minDepositPeriod,
        floorQuantity: building.floorQuantity,
        availableRooms: availableRooms,
        images: imageLinks,
        title: buildingTitle(building.buildingName, building.province, building.district, building.ward),
        generalAddress: {
          province: building.province,
          district: building.district,
          ward: building.ward,
        },
        status: (availableRooms.length > 0) ? 'Còn phòng' : 'Không còn phòng',
        area: roomGroup.area,
        capacity: roomGroup.capacity,
        gender: roomGroup.gender,
        amenities: totalAmenities,
        description: roomGroup.description,
        roomCost: {
          price: roomGroup.rentPrice,
          deposit: roomGroup.depositPrice,
        },
        services: services,
        hostId: host.id,
        hostAvatar: host.avatar,
        hostPhone: host.phoneNumber,
        hostName: host.firstName + " " + host.lastName,
        rating: {
          number_of_reviews: rating[0].number_of_reviews,
          accuracy_rate: rating[0].accuracy_rate,
          host_rate: rating[0].host_rate,
          security_rate: rating[0].security_rate,
        },
        reviewList: {
          tenantAvatars,
          tenantIds,
          tenantComments
        }
      }
    };
  }

  async getRoomGroupTransactionDetail(roomGroupId: any, userId: any) {
    if (Number.isInteger(roomGroupId)) {
      return null;
    }
    const roomGroup = await RoomGroup.repo.findOne(roomGroupId);
    const building = await Building.repo.findOne(roomGroup.buildingId);
    if (building == null) {
      return null;
    }
    const buildingTypeArray = await RoomType.repo.getBuildingType(building.typeId);
    const availableRooms = await Room.repo.getAvailableRoomsInGroup(roomGroupId);
    //const phone = await User.repo.getHostPhone(building.hostId);
    const host = await User.repo.findOne(building.hostId);
    if (host == null) {
      return null;
    }
    const images = await this.getImages(roomGroupId);
    let imageLinks = [];
    images.forEach(function(element) {
      let temp = [element.image_url];
      imageLinks = imageLinks.concat(temp);
    });
    //console.log(roomGroupId + ", " + userId);
    let transactionStatuses
    if (host.id == userId) {
      console.log("host");
      transactionStatuses = await Transaction.repo.getTransactionStatusForHost(roomGroupId);
    } else {
      console.log("tenant");
      transactionStatuses = await Transaction.repo.getTransactionStatus(roomGroupId, userId);
    }
    //console.log(transactionStatuses);
    let statusValue = null;
    if (transactionStatuses.length == 0) {
      transactionStatuses = null;
    } else {
      for (const status of transactionStatuses) {
        //console.log(status);
        /*if (status.transaction_status == ConstantValues.HOST_REJECTED) {
          statusValue = ConstantValues.HOST_REJECTED;
        } */
        statusValue = status.transaction_status;
      }
    }
    //console.log(statusValue);
    const data = {
      data : {
        availableRooms: availableRooms,
        images: imageLinks,
        title: buildingTitle(building.buildingName, building.province, building.district, building.ward),
        buildingTypeId: building.typeId,
        direction: roomGroup.direction,
        floorQuantity: building.floorQuantity,
        wcQuantity: roomGroup.wcQuantity,
        bedroomQuantity: roomGroup.bedroomQuantity,
        bathroomQuantity: roomGroup.bathroomQuantity,
        minDepositPeriod: roomGroup.minDepositPeriod,
        hostId: host.id,
        status: statusValue,
        transactionStatuses: transactionStatuses
      }
    };
    return data;
  }

}
