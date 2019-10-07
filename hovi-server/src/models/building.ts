import {
    BaseEntity,
    Column,
    Entity,
    EntityRepository, getCustomRepository,
    Repository,
    PrimaryColumn, Index, ManyToOne, JoinColumn, OneToMany
} from 'typeorm';
import {RoomType} from "./room_type";
import {User} from "./user";

@Entity(Building.tableName)
export class Building extends BaseEntity {
    static readonly tableName = 'building';
    static readonly schema = {
        id: 'building_id',
        typeId: 'room_type_id',
        floor: 'floor_quantity',
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

    @ManyToOne(type => RoomType, roomType => roomType.buildings)
    @JoinColumn({name: Building.schema.typeId})
    roomType: RoomType;
    @Column({name: Building.schema.typeId})
    typeId: number;

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

    @OneToMany(type => User, user => user.building)
    @JoinColumn({name: Building.schema.id})
    users: User[];

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
            building.floor = buildingUpdate.floor ? buildingUpdate.floor : building.floor;
            building.bedroom = buildingUpdate.bedroom ? buildingUpdate.bedroom : building.bedroom;
            building.bathroom = buildingUpdate.bathroom ? buildingUpdate.bathroom : building.bathroom;
            building.wc = buildingUpdate.wc ? buildingUpdate.wc : building.wc;
            building.create = buildingUpdate.create ? buildingUpdate.create : building.create;
            building.update = buildingUpdate.update ? buildingUpdate.update : building.update;
            await this.save(building);
        }
        return building;
    }
}
