import {
    BaseEntity,
    Unique,
    Column,
    Entity,
    EntityRepository, getCustomRepository,
    Repository,
    PrimaryColumn, Index, OneToMany, JoinColumn
} from 'typeorm';
import {Length} from 'class-validator';
import {Building} from "./building";

@Entity(RoomType.tableName)
@Unique(["type"])
export class RoomType extends BaseEntity {
    static readonly tableName = 'room_type';
    static readonly schema = {
        id: 'type_id',
        type: 'room_type',
        create: 'created_at',
        update: 'updated_at'
    };

    @PrimaryColumn({
        type: "int",
        generated: true,
        unsigned: true,
        name: RoomType.schema.id
    })
    id: number;


    @Column({
        type: "varchar",
        length: 1000,
        unique: true,
        name: RoomType.schema.type
    })
    @Index({ unique: true })
    @Length(0, 1000)
    type: string;

    @Column({
        type: "timestamp",
        precision: 6,
        default: () => "CURRENT_TIMESTAMP(6)",
        onUpdate: "CURRENT_TIMESTAMP(6)",
        name: RoomType.schema.create
    })
    create: Date;

    @Column({
        type: "timestamp",
        precision: 6,
        default: () => "CURRENT_TIMESTAMP(6)",
        onUpdate: "CURRENT_TIMESTAMP(6)",
        name: RoomType.schema.update
    })
    update: Date;

    @OneToMany(type => Building, building => building.roomType)
    @JoinColumn({name: RoomType.schema.id})
    buildings: Building[];

    static get repo(): RoomTypeRepository {
        return getCustomRepository(RoomTypeRepository);
    }
}

@EntityRepository(RoomType)
export class RoomTypeRepository extends Repository<RoomType> {
    async updateById(roomTypeId: any, roomTypeUpdate: RoomType) {
        let roomType = await this.findOne(roomTypeId);
        if (roomType) {
            roomType.type = roomTypeUpdate.type ? roomTypeUpdate.type : roomType.type;
            roomType.create = roomTypeUpdate.create ? roomTypeUpdate.create : roomType.create;
            roomType.update = roomTypeUpdate.update ? roomTypeUpdate.update : roomType.update;
            await this.save(roomType);
        }
        return roomType;
    }
}
