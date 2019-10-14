import {
    BaseEntity,
    Column,
    Entity,
    EntityRepository, getCustomRepository,
    Repository,
    PrimaryColumn, Index, ManyToOne, JoinColumn, OneToMany
} from 'typeorm';
import {RoomType} from "./building_type";
import {User} from "./user";
import {RoomGroup} from "./room_group";
import {BuildingService} from "./building_service";
import {Length} from "class-validator";

@Entity(Building.tableName)
export class Building extends BaseEntity {
    static readonly tableName = 'building';
    static readonly schema = {
        id: 'building_id',
        buildingName: 'building_name',
        typeId: 'building_type_id',
        isMixGender: 'is_mix_gender',
        province: 'province',
        district: 'district',
        ward: 'ward',
        street: 'street',
        detailedAddress: 'detailed_address',
        location: 'location',
        floor: 'floor_quantity',
        hostId: 'host_id',
        bedroom: 'bedroom_quantity',
        bathroom: 'bathroom_quantity',
        wc: 'wc_quantity',
        isVerified: 'is_verified',
        create: 'created_at',
        update: 'updated_at'
    };

    @PrimaryColumn({
        type: "int",
        generated: true,
        unsigned: true,
        name: Building.schema.id
    })
    id: number;

    @Column({
        type: "varchar",
        length: 255,
        unique: false,
        name: Building.schema.buildingName
    })
    buildingName: string;

    @ManyToOne(type => RoomType, roomType => roomType.buildings)
    @JoinColumn({name: Building.schema.typeId})
    roomType: RoomType;
    @Column({name: Building.schema.typeId})
    typeId: number;

    @ManyToOne(type => User, user => user.buildings)
    @JoinColumn({name: Building.schema.hostId})
    host: User;
    @Column({name: Building.schema.hostId})
    hostId: number;

    @Column({
        type: "bit",
        unique: false,
        name: Building.schema.isMixGender
    })
    isMixGender: boolean;

    @Column({
        type: "varchar",
        length: 255,
        unique: false,
        name: Building.schema.province
    })
    @Length(0, 255)
    province: string;

    @Column({
        type: "varchar",
        length: 255,
        unique: false,
        name: Building.schema.district
    })
    @Length(0, 255)
    district: string;

    @Column({
        type: "varchar",
        length: 255,
        unique: false,
        name: Building.schema.ward
    })
    @Length(0, 255)
    ward: string;

    @Column({
        type: "varchar",
        length: 255,
        unique: false,
        name: Building.schema.street
    })
    @Length(0, 255)
    street: string;

    @Column({
        type: "text",
        unique: false,
        name: Building.schema.detailedAddress
    })
    detailedAddress: string;

    @Column({
        type: "text",
        unique: false,
        name: Building.schema.location
    })
    location: string;

    @Column({
        type: "int",
        unique: false,
        name: Building.schema.floor
    })
    floor: number;



    @Column({
        type: "bit",
        unique: false,
        name: Building.schema.isVerified
    })
    isVerified: boolean;
    
    @Column({
        type: "timestamp",
        precision: 6,
        default: () => "CURRENT_TIMESTAMP(6)",
        onUpdate: "CURRENT_TIMESTAMP(6)",
        name: Building.schema.create
    })
    create: Date;

    @Column({
        type: "timestamp",
        precision: 6,
        default: () => "CURRENT_TIMESTAMP(6)",
        onUpdate: "CURRENT_TIMESTAMP(6)",
        name: Building.schema.update
    })
    update: Date;

    @OneToMany(type => RoomGroup, roomGroup => roomGroup.building)
    @JoinColumn({name: Building.schema.id})
    roomGroups: RoomGroup[];

    @OneToMany(type => BuildingService, buildingService => buildingService.building)
    @JoinColumn({name: Building.schema.id})
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
            building.isMixGender = buildingUpdate.isMixGender ? buildingUpdate.isMixGender : building.isMixGender;
            building.province = buildingUpdate.province ? buildingUpdate.province : building.province;
            building.district = buildingUpdate.district ? buildingUpdate.district : building.district;
            building.ward = buildingUpdate.ward ? buildingUpdate.ward : building.ward;
            building.street = buildingUpdate.street ? buildingUpdate.street : building.street;
            building.detailedAddress = buildingUpdate.detailedAddress ? buildingUpdate.detailedAddress : building.detailedAddress;
            building.location = buildingUpdate.location ? buildingUpdate.location : building.location;
            building.floor = buildingUpdate.floor ? buildingUpdate.floor : building.floor;
            building.isVerified = buildingUpdate.isVerified ? buildingUpdate.isVerified : building.isVerified;
            building.create = buildingUpdate.create ? buildingUpdate.create : building.create;
            building.update = buildingUpdate.update ? buildingUpdate.update : building.update;
            await this.save(building);
        }
        return building;
    }
}
