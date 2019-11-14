import {
  BaseEntity,
  Column,
  Entity,
  EntityRepository, getCustomRepository,
  Repository,
  PrimaryColumn, ManyToOne, JoinColumn, getRepository,
} from 'typeorm';
import {IsUrl} from 'class-validator';
import { RoomGroup } from './room-group';

@Entity(RoomImage.tableName)
export class RoomImage extends BaseEntity {
  static readonly tableName = 'room_image';
  static readonly schema = {
    imageId: 'image_id',
    roomGroupId: 'room_group_id',
    imageUrl: 'image_url',
    createAt: 'created_at',
    updateAt: 'updated_at',
  };

  @PrimaryColumn({
    type: 'int',
    generated: true,
    unsigned: true,
    name: RoomImage.schema.imageId,
  })
  imageId: number;

  @ManyToOne(type => RoomGroup, roomGroup => roomGroup.roomImages)
  @JoinColumn({ name: RoomImage.schema.roomGroupId })
  roomGroup: RoomGroup;
  @Column({ name: RoomImage.schema.roomGroupId })
  roomGroupId: number;

  @Column({
    type: 'text',
    unique: true,
    name: RoomImage.schema.imageUrl,
  })
  @IsUrl()
  imageUrl: string;


  @Column({
    type: 'timestamp',
    name: RoomImage.schema.createAt,
  })
  createAt: Date;

  @Column({
    type: 'timestamp',
    name: RoomImage.schema.updateAt,
  })
  updateAt: Date;


  static get repo(): RoomImageRepository {
    return getCustomRepository(RoomImageRepository);
  }
}

@EntityRepository(RoomImage)
export class RoomImageRepository extends Repository<RoomImage> {
  async updateById(roomImageId: any, roomImageUpdate: RoomImage) {
    let roomImage = await this.findOne(roomImageId);
    if (roomImage) {
      roomImage.imageUrl = roomImageUpdate.imageUrl ? roomImageUpdate.imageUrl : roomImage.imageUrl;
      await this.save(roomImage);
    }
    return roomImage;
  }

  async getOneRecord(roomGroupId: any, imageId: any) {
    return await getRepository(RoomImage)
      .createQueryBuilder('roomImages')
      .where('room_group_id = :roomGroupId', { roomGroupId })
      .andWhere('roomImages.imageId = :imageId', { imageId })
      .getOne();
  }
}
