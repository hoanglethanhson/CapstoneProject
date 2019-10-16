import {
    BaseEntity,
    Column,
    Entity,
    EntityRepository, getCustomRepository,
    Repository,
    PrimaryColumn, ManyToOne, JoinColumn, OneToMany
} from 'typeorm';
import {Building} from "./building";
import {Room} from "./room";
import {RoomAmenities} from "./room_amenities";
import {Length} from "class-validator";

@Entity(RoomGroup.tableName)
export class RoomGroup extends BaseEntity {
    static readonly tableName = 'room_group';
    static readonly schema = {
        id: 'room_group_id',
        buildingId: 'building_id',
        gender: 'gender',
        rentPrice: 'rent_price',
        area: 'aera',
        bedroom: 'bedroom_quantity',
        bathroom: 'bathroom_quantity',
        wc: 'wc_quantity',
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
        create: 'created_at',
        update: 'updated_at'
    };

    @PrimaryColumn({
        type: "int",
        generated: true,
        unsigned: true,
        name: RoomGroup.schema.id
    })
    id: number;

    @ManyToOne(type => Building, building => building.roomGroups)
    @JoinColumn({name: RoomGroup.schema.buildingId})
    building: Building;
    @Column({name: RoomGroup.schema.buildingId})
    buildingId: number;

    @Column({
        type: "bit",
        unique: false,
        name: RoomGroup.schema.gender
    })
    gender: boolean;

    @Column({
        type: "double",
        unique: false,
        name: RoomGroup.schema.rentPrice
    })
    rentPrice: number;

    @Column({
        type: "double",
        unique: false,
        name: RoomGroup.schema.area
    })
    area: number;

    @Column({
        type: "int",
        unique: false,
        name: RoomGroup.schema.bedroom
    })
    bedroom: number;

    @Column({
        type: "int",
        unique: false,
        name: RoomGroup.schema.bathroom
    })
    bathroom: number;

    @Column({
        type: "int",
        unique: false,
        name: RoomGroup.schema.wc
    })
    wc: number;

    @Column({
        type: "varchar",
        length: 255,
        unique: false,
        name: RoomGroup.schema.direction
    })
    @Length(0, 255)
    direction: string;

    @Column({
        type: "bit",
        unique: false,
        name: RoomGroup.schema.isAvailable
    })
    isAvailable: boolean;

    @Column({
        type: "bit",
        unique: false,
        name: RoomGroup.schema.isVerified
    })
    isVerified: boolean;


    @Column({
        type: "double",
        unique: false,
        name: RoomGroup.schema.depositPrice
    })
    depositPrice: number;

    @Column({
        type: "text",
        unique: false,
        name: RoomGroup.schema.description
    })
    description: string;

    @Column({
        type: "int",
        unique: false,
        name: RoomGroup.schema.capacity
    })
    capacity: number;

    @Column({
        type: "int",
        unique: false,
        name: RoomGroup.schema.quantity
    })
    quantity: number;

    @Column({
        type: "int",
        unique: false,
        name: RoomGroup.schema.viewAmount
    })
    viewAmount: number;

    @Column({
        type: "int",
        unique: false,
        name: RoomGroup.schema.phoneViewAmount
    })
    phoneViewAmount: number;

    @Column({
        type: "bit",
        unique: false,
        name: RoomGroup.schema.isSponsored
    })
    isSponsored: boolean;

    @Column({
        type: "timestamp",
        precision: 6,
        default: () => "CURRENT_TIMESTAMP(6)",
        onUpdate: "CURRENT_TIMESTAMP(6)",
        name: RoomGroup.schema.create
    })
    create: Date;

    @Column({
        type: "timestamp",
        precision: 6,
        default: () => "CURRENT_TIMESTAMP(6)",
        onUpdate: "CURRENT_TIMESTAMP(6)",
        name: RoomGroup.schema.update
    })
    update: Date;

    @OneToMany(type => Room, room => room.roomGroup)
    @JoinColumn({name: RoomGroup.schema.id})
    rooms: Room[];

    @OneToMany(type => RoomAmenities, roomAmenities => roomAmenities.roomGroup)
    @JoinColumn({name: RoomGroup.schema.id})
    roomAmenities: RoomAmenities[];

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
            roomGroup.bedroom = roomGroupUpdate.bedroom ? roomGroupUpdate.bedroom : roomGroup.bedroom;
            roomGroup.bathroom = roomGroupUpdate.bathroom ? roomGroupUpdate.bathroom : roomGroup.bathroom;
            roomGroup.wc = roomGroupUpdate.wc ? roomGroupUpdate.wc : roomGroup.wc;
            roomGroup.direction = roomGroupUpdate.direction ? roomGroupUpdate.direction : roomGroup.direction;
            roomGroup.isAvailable = roomGroupUpdate.isAvailable ? roomGroupUpdate.isAvailable : roomGroup.isAvailable;
            roomGroup.isVerified = roomGroupUpdate.isVerified ? roomGroupUpdate.isVerified : roomGroup.isVerified;
            roomGroup.depositPrice = roomGroupUpdate.depositPrice ? roomGroupUpdate.depositPrice : roomGroup.depositPrice;
            roomGroup.description = roomGroupUpdate.description ? roomGroupUpdate.description : roomGroup.description;
            roomGroup.capacity = roomGroupUpdate.capacity ? roomGroupUpdate.capacity : roomGroup.capacity;
            roomGroup.quantity = roomGroupUpdate.quantity ? roomGroupUpdate.quantity : roomGroup.quantity;
            roomGroup.viewAmount = roomGroupUpdate.viewAmount ? roomGroupUpdate.viewAmount : roomGroup.viewAmount;
            roomGroup.phoneViewAmount = roomGroupUpdate.phoneViewAmount ? roomGroupUpdate.phoneViewAmount : roomGroup.phoneViewAmount;
            roomGroup.isSponsored = roomGroupUpdate.isSponsored ? roomGroupUpdate.isSponsored : roomGroup.isSponsored;
            await this.save(roomGroup);
        }
        return roomGroup;
    }
}
