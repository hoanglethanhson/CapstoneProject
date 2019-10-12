import {
    BaseEntity,
    Unique,
    Column,
    Entity,
    EntityRepository, getCustomRepository,
    Repository,
    PrimaryColumn, Index, OneToMany, JoinColumn
} from 'typeorm';
import {MaxLength, Length} from 'class-validator';
import {RoomAmenities} from "./room_amenities";

@Entity(Amenities.tableName)
@Unique(["usableName"])
//@Unique(["unusableName"])
export class Amenities extends BaseEntity {
    static readonly tableName = 'amenities';
    static readonly schema = {
        id: 'amenities_id',
        usableName: 'usable_name',
        unusableName: 'unsuable_name',
        description: 'description',
        url: 'icon_url',
        create: 'created_at',
        update: 'updated_at'
    };

    @PrimaryColumn({
        type: "int",
        generated: true,
        unsigned: true,
        name: Amenities.schema.id
    })
    id: number;

    @Column({
        type: "varchar",
        length: 255,
        unique: true,
        name: Amenities.schema.usableName
    })
    @Length(0, 255)
    usableName: string;

    @Column({
        type: "varchar",
        length: 255,
        unique: true,
        name: Amenities.schema.unusableName
    })
    @Length(0, 255)
    unusableName: string;

    @Column({
        type: "text",
        unique: false,
        name: Amenities.schema.description
    })
    description: string;

    @Column({
        type: "text",
        unique: true,
        name: Amenities.schema.url
    })
    url: string;

    @Column({
        type: "timestamp",
        precision: 6,
        default: () => "CURRENT_TIMESTAMP(6)",
        onUpdate: "CURRENT_TIMESTAMP(6)",
        name: Amenities.schema.create
    })
    create: Date;

    @Column({
        type: "timestamp",
        precision: 6,
        default: () => "CURRENT_TIMESTAMP(6)",
        onUpdate: "CURRENT_TIMESTAMP(6)",
        name: Amenities.schema.update
    })
    update: Date;

    @OneToMany(type => RoomAmenities, roomAmenities => roomAmenities.amenities)
    @JoinColumn({name: Amenities.schema.id})
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
            amenities.usableName = amenitiesUpdate.usableName ? amenitiesUpdate.usableName : amenities.usableName;
            amenities.unusableName = amenitiesUpdate.unusableName ? amenitiesUpdate.unusableName : amenities.unusableName;
            amenities.description = amenitiesUpdate.description ? amenitiesUpdate.description : amenities.description;
            amenities.url = amenitiesUpdate.url ? amenitiesUpdate.url : amenities.url;
            amenities.create = amenitiesUpdate.create ? amenitiesUpdate.create : amenities.create;
            amenities.update = amenitiesUpdate.update ? amenitiesUpdate.update : amenities.update;
            await this.save(amenities);
        }
        return amenities;
    }
}
