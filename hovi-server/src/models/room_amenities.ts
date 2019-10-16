import {
    BaseEntity,
    Column,
    Entity,
    EntityRepository, getCustomRepository,
    Repository,
    PrimaryColumn, Index, ManyToOne, JoinColumn, createQueryBuilder, getRepository, getConnection, getManager
} from 'typeorm';
import {RoomGroup} from "./room_group";
import {Amenities} from "./amenities";

@Entity(RoomAmenities.tableName)
export class RoomAmenities extends BaseEntity {
    static readonly tableName = 'room_amenities';
    static readonly schema = {
        roomGroupId: 'room_group_id',
        amenitiesId: 'amenities_id',
        createAt: 'created_at',
        updateAt: 'updated_at'
    };


    @ManyToOne(type => RoomGroup, roomGroup => roomGroup.roomAmenities)
    @JoinColumn({name: RoomAmenities.schema.roomGroupId})
    roomGroup: RoomGroup;
    @PrimaryColumn({name: RoomAmenities.schema.roomGroupId})
    roomGroupId: number;


    @ManyToOne(type => Amenities, amenities => amenities.roomAmenities)
    @JoinColumn({name: RoomAmenities.schema.amenitiesId})
    amenities: Amenities;
    @PrimaryColumn({name: RoomAmenities.schema.amenitiesId})
    amenitiesId: number;

    @Column({
        type: "timestamp",
        precision: 6,
        default: () => "CURRENT_TIMESTAMP(6)",
        onUpdate: "CURRENT_TIMESTAMP(6)",
        name: RoomAmenities.schema.createAt
    })
    createAt: Date;

    @Column({
        type: "timestamp",
        precision: 6,
        default: () => "CURRENT_TIMESTAMP(6)",
        onUpdate: "CURRENT_TIMESTAMP(6)",
        name: RoomAmenities.schema.updateAt
    })
    updateAt: Date;


    static get repo(): RoomAmenitiesRepository {
        return getCustomRepository(RoomAmenitiesRepository);
    }
}

@EntityRepository(RoomAmenities)
export class RoomAmenitiesRepository extends Repository<RoomAmenities> {
    async updateById(roomGroupId: any, amenitiesId: any, roomAmenitiesUpdate: RoomAmenities) {
        let roomAmenities = await this.getOneRecord(roomGroupId, amenitiesId);
        if (roomAmenities) {
            roomAmenities.roomGroupId = roomAmenitiesUpdate.roomGroupId ? roomAmenitiesUpdate.roomGroupId : roomAmenities.roomGroupId;
            roomAmenities.amenitiesId = roomAmenitiesUpdate.amenitiesId ? roomAmenitiesUpdate.amenitiesId : roomAmenities.amenitiesId;
            roomAmenities.createAt = roomAmenitiesUpdate.createAt ? roomAmenitiesUpdate.createAt : roomAmenities.createAt;
            roomAmenities.updateAt = roomAmenitiesUpdate.updateAt ? roomAmenitiesUpdate.updateAt : roomAmenities.updateAt;
            await this.save(roomAmenities);
        }
        return roomAmenities;
    }

    async getAmenitiesInRoomGroup(roomGroupId: any) {
        const amenities = await getRepository(RoomGroup)
            .createQueryBuilder("roomGroup")
            .select(["roomGroup.id","roomAmenities.amenitiesId", "roomAmenities.roomGroupId"])
            .where("roomAmenities.roomGroupId = :roomGroupId", {roomGroupId: roomGroupId})
            .innerJoin("roomGroup.roomAmenities", "roomAmenities")
            .getMany();
        return amenities;
    }

    async getOneRecord(roomGroupId: any, amenitiesId: any) {
        const record = await getRepository(RoomAmenities)
            .createQueryBuilder("roomAmenities")
            .where("room_group_id = :roomGroupId", {roomGroupId: roomGroupId})
            .andWhere("roomAmenities.amenitiesId = :amenitiesId", {amenitiesId: amenitiesId})
            .getOne();
        return record;
    }

    async deleteOneRecord(roomGroupId: any, amenitiesId: any) {
        const record = await getConnection()
            .createQueryBuilder()
            .delete()
            .from(RoomAmenities)
            .where("roomGroupId = :roomGroupId", {roomGroupId: roomGroupId})
            .andWhere("amenitiesId = :amenitiesId", {amenitiesId: amenitiesId})
            .execute();
        return record;
    }

    async getAmenitiesDetailRoomGroup(roomGroupId: any) {
        const amenities = await getManager()
            .createQueryBuilder(RoomAmenities, "room_amenities")
            .select(["room_amenities.amenities_id", "amenities.usable_name"])
            //.addSelect("room_amenities.amenities_id", "id")
            //.addSelect("amenities.usable_name", "name")
            .innerJoin(RoomGroup, "room_group", "room_group.room_group_id = room_amenities.room_group_id")
            .innerJoin(Amenities, "amenities", "room_amenities.amenities_id = amenities.amenities_id")
            .where("room_amenities.room_group_id = :room_group_id", {room_group_id: roomGroupId})
            .getRawMany();
        return amenities;
    }
}

/*
const record = await getRepository(RoomAmenities)
    .createQueryBuilder("roomAmenities")
    .where("roomAmenities.roomGroupId = :roomGroupId", {roomGroupId: roomGroupId})
    .andWhere("roomAmenities.amenitiesId = :amenitiesId", {amenitiesId: amenitiesId})
    .getOne();
return record;*/
