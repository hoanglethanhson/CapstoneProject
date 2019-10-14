import {
    BaseEntity,
    Unique,
    Column,
    Entity,
    EntityRepository, getCustomRepository,
    Repository,
    PrimaryColumn, Index, ManyToOne, JoinColumn
} from 'typeorm';
import {Room} from "./room";


@Entity(RoomImage.tableName)
@Unique(["imageUrl"])
export class RoomImage extends BaseEntity {
    static readonly tableName = 'room_image';
    static readonly schema = {
        id: 'image_id',
        roomId: 'room_id',
        imageUrl: 'image_url',
        createAt: 'created_at',
        updateAt: 'updated_at'
    };

    @PrimaryColumn({
        type: "int",
        generated: true,
        unsigned: true,
        name: RoomImage.schema.id
    })
    id: number;

    @ManyToOne(type => Room, room => room.roomImages)
    @JoinColumn({name: RoomImage.schema.roomId})
    room: Room;
    @Column({name: RoomImage.schema.roomId})
    roomId: number;

    @Column({
        type: "text",
        unique: true,
        name: RoomImage.schema.imageUrl
    })
    imageUrl: string;


    @Column({
        type: "timestamp",
        precision: 6,
        default: () => "CURRENT_TIMESTAMP(6)",
        onUpdate: "CURRENT_TIMESTAMP(6)",
        name: RoomImage.schema.createAt
    })
    createAt: Date;

    @Column({
        type: "timestamp",
        precision: 6,
        default: () => "CURRENT_TIMESTAMP(6)",
        onUpdate: "CURRENT_TIMESTAMP(6)",
        name: RoomImage.schema.updateAt
    })
    updateAt: Date;


    static get repo(): RoomImageRepository {
        return getCustomRepository(RoomImageRepository);
    }
}

@EntityRepository(RoomImage)
export class RoomImageRepository extends Repository<RoomImage> {
    async updateById(roomImageId: any, roomImageUpdate: RoomImage) {
        let roomImage = await this.findOne(roomImageId);
        if (roomImage) {
            roomImage.roomId = roomImageUpdate.roomId ? roomImageUpdate.roomId : roomImage.roomId;
            roomImage.imageUrl = roomImageUpdate.imageUrl ? roomImageUpdate.imageUrl : roomImage.imageUrl;
            roomImage.createAt = roomImageUpdate.createAt ? roomImageUpdate.createAt : roomImage.createAt;
            roomImage.updateAt = roomImageUpdate.updateAt ? roomImageUpdate.updateAt : roomImage.updateAt;
            await this.save(roomImage);
        }
        return roomImage;
    }
}
