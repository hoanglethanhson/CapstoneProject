import {
  BaseEntity,
  Unique,
  Column,
  Entity,
  EntityRepository, getCustomRepository,
  Repository,
  PrimaryColumn, OneToMany, JoinColumn,
} from 'typeorm';
import { Length } from 'class-validator';
import { RoomAmenities } from './room-amenities';

@Entity(Amenities.tableName)
@Unique(['usableName'])
export class Amenities extends BaseEntity {
  static readonly tableName = 'amenities';
  static readonly schema = {
    id: 'amenities_id',
    iconId: 'icon_id',
    usableName: 'usable_name',
    unusableName: 'unusable_name',
    description: 'description',
    create: 'created_at',
    update: 'updated_at',
  };

  @PrimaryColumn({
    type: 'int',
    generated: true,
    unsigned: true,
    name: Amenities.schema.id,
  })
  id: number;

  @Column({
    type: 'varchar',
    length: 50,
    name: Amenities.schema.iconId,
  })
  @Length(0, 50)
  iconId: string;

  @Column({
    type: 'varchar',
    length: 255,
    unique: true,
    name: Amenities.schema.usableName,
  })
  @Length(0, 255)
  usableName: string;

  @Column({
    type: 'varchar',
    length: 255,
    unique: true,
    name: Amenities.schema.unusableName,
  })
  @Length(0, 255)
  unusableName: string;

  @Column({
    type: 'text',
    unique: false,
    name: Amenities.schema.description,
  })
  description: string;


  @Column({
    type: 'timestamp',
    name: Amenities.schema.create,
  })
  create: Date;

  @Column({
    type: 'timestamp',
    name: Amenities.schema.update,
  })
  update: Date;

  @OneToMany(type => RoomAmenities, roomAmenities => roomAmenities.amenities)
  @JoinColumn({ name: Amenities.schema.id })
  roomAmenities: RoomAmenities[];

  static get repo(): AmenitiesRepository {
    return getCustomRepository(AmenitiesRepository);
  }
}

@EntityRepository(Amenities)
export class AmenitiesRepository extends Repository<Amenities> {
  async updateById(amenitiesId: any, amenitiesUpdate: Amenities) {
    let amenities = await this.findOne(amenitiesId);
    if (amenities) {
      amenities.iconId = amenitiesUpdate.iconId ? amenitiesUpdate.iconId : amenities.iconId;
      amenities.usableName = amenitiesUpdate.usableName ? amenitiesUpdate.usableName : amenities.usableName;
      amenities.unusableName = amenitiesUpdate.unusableName ? amenitiesUpdate.unusableName : amenities.unusableName;
      amenities.description = amenitiesUpdate.description ? amenitiesUpdate.description : amenities.description;
      await this.save(amenities);
    }
    return amenities;
  }
}
