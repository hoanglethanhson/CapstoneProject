import {
    BaseEntity,
    Column,
    Entity,
    EntityRepository, getCustomRepository,
    Repository,
    PrimaryColumn, ManyToOne, JoinColumn, OneToMany
} from 'typeorm';
import {Length} from "class-validator";
import {RoomGroup} from "./room_group";
import {Transaction} from "./transaction";

@Entity(Room.tableName)
export class Room extends BaseEntity {
    static readonly tableName = 'room';
    static readonly schema = {
        id: 'room_id',
        roomGroupId: 'room_group_id',
        roomName: 'room_name',
        freeSlot: 'free_slot',
        createAt: 'created_at',
        updateAt: 'updated_at'
    };

    @PrimaryColumn({
        type: "int",
        generated: true,
        unsigned: true,
        name: Room.schema.id
    })
    id: number;

    @ManyToOne(type => RoomGroup, roomGroup => roomGroup.rooms)
    @JoinColumn({name: Room.schema.roomGroupId})
    roomGroup: RoomGroup;
    @Column({name: Room.schema.roomGroupId})
    roomGroupId: number;


    @Column({
        type: "text",
        unique: false,
        name: Room.schema.roomName
    })
    roomName: string;

    @Column({
        type: "int",
        unique: false,
        name: Room.schema.freeSlot
    })
    freeSlot: number;


    @Column({
        type: "timestamp",
        precision: 6,
        default: () => "CURRENT_TIMESTAMP(6)",
        onUpdate: "CURRENT_TIMESTAMP(6)",
        name: Room.schema.createAt
    })
    createAt: Date;

    @Column({
        type: "timestamp",
        precision: 6,
        default: () => "CURRENT_TIMESTAMP(6)",
        onUpdate: "CURRENT_TIMESTAMP(6)",
        name: Room.schema.updateAt
    })
    updateAt: Date;

    @OneToMany(type => Transaction, transaction => transaction.room)
    @JoinColumn({name: Room.schema.id})
    transactions: Transaction[];

    static get repo(): RoomRepository {
        return getCustomRepository(RoomRepository);
    }
}

@EntityRepository(Room)
export class RoomRepository extends Repository<Room> {
    async updateById(roomId: any, roomUpdate: Room) {
        let room = await this.findOne(roomId);
        if (room) {
            room.roomGroupId = roomUpdate.roomGroupId ? roomUpdate.roomGroupId : room.roomGroupId;
            room.roomName = roomUpdate.roomName ? roomUpdate.roomName : room.roomName;
            room.freeSlot = roomUpdate.freeSlot ? roomUpdate.freeSlot : room.freeSlot;
            room.createAt = roomUpdate.createAt ? roomUpdate.createAt : room.createAt;
            room.updateAt = roomUpdate.updateAt ? roomUpdate.updateAt : room.updateAt;
            await this.save(room);
        }
        return room;
    }
}
