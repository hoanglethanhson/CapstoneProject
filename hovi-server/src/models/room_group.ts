import {
    BaseEntity,
    Column,
    Entity,
    EntityRepository, getCustomRepository,
    Repository,
    PrimaryColumn, ManyToOne, JoinColumn, OneToMany
} from 'typeorm';
import {Building} from "./building";
console.log(Building)

@Entity(RoomGroup.tableName)
export class RoomGroup extends BaseEntity {
    static readonly tableName = 'room_group';
    static readonly schema = {
        id: 'room_group_id',
        buildingId: 'building_id',
        gender: 'gender',
        rentPrice: 'rent_price',
        area: 'aera',
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

    static get repo(): RoomGroupRepository {
        return getCustomRepository(RoomGroupRepository);
    }
}

@EntityRepository(Building)
export class RoomGroupRepository extends Repository<RoomGroup> {
    async updateById(roomGroupId: any, roomGroupUpdate: RoomGroup) {
        let roomGroup = await this.findOne(roomGroupId);
        if (roomGroup) {
            roomGroup.buildingId = roomGroupUpdate.buildingId ? roomGroupUpdate.buildingId : roomGroup.buildingId;
            roomGroup.gender = roomGroupUpdate.gender ? roomGroupUpdate.gender : roomGroup.gender;
            roomGroup.rentPrice = roomGroupUpdate.rentPrice ? roomGroupUpdate.rentPrice : roomGroup.rentPrice;
            roomGroup.area = roomGroupUpdate.area ? roomGroupUpdate.area : roomGroup.area;
            roomGroup.isAvailable = roomGroupUpdate.isAvailable ? roomGroupUpdate.isAvailable : roomGroup.isAvailable;
            roomGroup.isVerified = roomGroupUpdate.isVerified ? roomGroupUpdate.isVerified : roomGroup.isVerified;
            roomGroup.depositPrice = roomGroupUpdate.depositPrice ? roomGroupUpdate.depositPrice : roomGroup.depositPrice;
            roomGroup.depositPrice = roomGroupUpdate.depositPrice ? roomGroupUpdate.depositPrice : roomGroup.depositPrice;
            roomGroup.description = roomGroupUpdate.description ? roomGroupUpdate.description : roomGroup.description;
            roomGroup.capacity = roomGroupUpdate.capacity ? roomGroupUpdate.capacity : roomGroup.capacity;
            roomGroup.quantity = roomGroupUpdate.quantity ? roomGroupUpdate.quantity : roomGroup.quantity;
            roomGroup.viewAmount = roomGroupUpdate.viewAmount ? roomGroupUpdate.viewAmount : roomGroup.viewAmount;
            roomGroup.phoneViewAmount = roomGroupUpdate.phoneViewAmount ? roomGroupUpdate.phoneViewAmount : roomGroup.phoneViewAmount;
            roomGroup.isSponsored = roomGroupUpdate.isSponsored ? roomGroupUpdate.isSponsored : roomGroup.isSponsored;
            roomGroup.create = roomGroupUpdate.create ? roomGroupUpdate.create : roomGroup.create;
            roomGroup.update = roomGroupUpdate.update ? roomGroupUpdate.update : roomGroup.update;
            await this.save(roomGroup);
        }
        return roomGroup;
    }
}
