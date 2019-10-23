import {
    BaseEntity,
    Unique,
    Column,
    Entity,
    EntityRepository, getCustomRepository,
    Repository,
    PrimaryColumn, Index, OneToMany, JoinColumn, getRepository, getManager
} from 'typeorm';
import {Length} from 'class-validator';
import {Building} from "./building";

@Entity(RoomType.tableName)
@Unique(["type"])
export class RoomType extends BaseEntity {
    static readonly tableName = 'building_type';
    static readonly schema = {
        id: 'type_id',
        type: 'building_type',
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
        length: 255,
        unique: true,
        name: RoomType.schema.type
    })
    @Index({ unique: true })
    @Length(0, 255)
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

    async getBuildingType(typeId: number) {
        const result = await getRepository(RoomType)
            .createQueryBuilder("building_type")
            .select(["building_type.building_type"])
            .where("building_type.type_id = :typeId", {typeId: typeId})
            .getOne();
        const al = await this.manager.query("SELECT building_type from building_type WHERE type_id = ?", [typeId]);
        return al;
    }
}
