import {
    BaseEntity,
    Unique,
    Column,
    Entity,
    EntityRepository, getCustomRepository,
    Repository,
    PrimaryColumn, Index, ManyToOne, JoinColumn
} from 'typeorm';
import {RoomGroup} from "./room_group";


@Entity(RoomImage.tableName)
@Unique(["imageUrl"])
export class RoomImage extends BaseEntity {
    static readonly tableName = 'room_image';
    static readonly schema = {
        id: 'image_id',
        roomGroupId: 'room_group_id',
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

    @ManyToOne(type => RoomGroup, roomGroup => roomGroup.roomImages)
    @JoinColumn({name: RoomImage.schema.roomGroupId})
    roomGroup: RoomGroup;
    @Column({name: RoomImage.schema.roomGroupId})
    roomGroupId: number;

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
            roomImage.roomGroupId = roomImageUpdate.roomGroupId ? roomImageUpdate.roomGroupId : roomImage.roomGroupId;
            roomImage.imageUrl = roomImageUpdate.imageUrl ? roomImageUpdate.imageUrl : roomImage.imageUrl;
            roomImage.createAt = roomImageUpdate.createAt ? roomImageUpdate.createAt : roomImage.createAt;
            roomImage.updateAt = roomImageUpdate.updateAt ? roomImageUpdate.updateAt : roomImage.updateAt;
            await this.save(roomImage);
        }
        return roomImage;
    }
}
