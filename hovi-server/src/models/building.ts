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

@Entity(Building.tableName)
export class Building extends BaseEntity {
    static readonly tableName = 'building';
    static readonly schema = {
        id: 'building_id',
        buildingName: 'building_name',
        typeId: 'building_type_id',
        isMixGender: 'is_mix_gender',
        generalAddress: 'general_address',
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
        type: "text",
        unique: false,
        name: Building.schema.generalAddress
    })
    generalAddress: string;

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
        type: "int",
        unique: false,
        name: Building.schema.bedroom
    })
    bedroom: number;

    @Column({
        type: "int",
        unique: false,
        name: Building.schema.bathroom
    })
    bathroom: number;

    @Column({
        type: "int",
        unique: false,
        name: Building.schema.wc
    })
    wc: number;

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
            building.hostId = buildingUpdate.hostId ? buildingUpdate.hostId : building.hostId;
            building.generalAddress = buildingUpdate.generalAddress ? buildingUpdate.generalAddress : building.generalAddress;
            building.detailedAddress = buildingUpdate.detailedAddress ? buildingUpdate.detailedAddress : building.detailedAddress;
            building.location = buildingUpdate.location ? buildingUpdate.location : building.location;
            building.floor = buildingUpdate.floor ? buildingUpdate.floor : building.floor;
            building.bedroom = buildingUpdate.bedroom ? buildingUpdate.bedroom : building.bedroom;
            building.bathroom = buildingUpdate.bathroom ? buildingUpdate.bathroom : building.bathroom;
            building.wc = buildingUpdate.wc ? buildingUpdate.wc : building.wc;
            building.isVerified = buildingUpdate.isVerified ? buildingUpdate.isVerified : building.isVerified;
            building.create = buildingUpdate.create ? buildingUpdate.create : building.create;
            building.update = buildingUpdate.update ? buildingUpdate.update : building.update;
            await this.save(building);
        }
        return building;
    }
}
