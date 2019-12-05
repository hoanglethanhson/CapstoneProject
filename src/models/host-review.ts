import {
    BaseEntity,
    Column,
    Entity,
    EntityRepository,
    getCustomRepository,
    Repository,
    PrimaryColumn,
    ManyToOne,
    JoinColumn,
    CreateDateColumn,
    UpdateDateColumn, getRepository, getManager
} from 'typeorm';
import {User} from "./user";
import {RoomGroup} from "./room-group";
import {Building} from "./building";
import {Transaction} from "./transaction";
import {ConstantValues} from "../utils/constant-values";
import {Room} from "./room";

@Entity(HostReview.tableName)
export class HostReview extends BaseEntity {
    static readonly tableName = 'host_review';
    static readonly schema = {
        reviewId: 'review_id',
        hostId: 'host_id',
        tenantId: 'tenant_id',
        comment: 'comment',
        createAt: 'created_at',
        updateAt: 'updated_at'
    };

    @PrimaryColumn({
        type: "int",
        generated: true,
        unsigned: true,
        name: HostReview.schema.reviewId
    })
    reviewId: number;

    @ManyToOne(type => User, user => user.hosts)
    @JoinColumn({name: HostReview.schema.hostId})
    host: User;
    @Column({name: HostReview.schema.hostId})
    hostId: number;

    @ManyToOne(type => User, user => user.tenants)
    @JoinColumn({name: HostReview.schema.tenantId})
    tenant: User;
    @Column({name: HostReview.schema.tenantId})
    tenantId: number;


    @Column({
        type: "text",
        unique: false,
        name: HostReview.schema.comment
    })
    comment: number;

    @CreateDateColumn({
        type: "timestamp",
        name: HostReview.schema.createAt
    })
    createAt: Date;

    @UpdateDateColumn({
        type: "timestamp",
        name: HostReview.schema.updateAt
    })
    updateAt: Date;

    static get repo(): HostReviewRepository {
        return getCustomRepository(HostReviewRepository);
    }
}

@EntityRepository(HostReview)
export class HostReviewRepository extends Repository<HostReview> {
    async updateById(reviewId: any, reviewUpdate: HostReview) {
        let review = await this.findOne(reviewId);
        if (review) {
            review.hostId = reviewUpdate.hostId ;
            review.tenantId = reviewUpdate.tenantId;
            review.comment = reviewUpdate.comment ;
            review.createAt = reviewUpdate.createAt;
            review.updateAt = reviewUpdate.updateAt;
            await this.save(review);
        }
        return review;
    }

    async isBeingHostAndTenant(hostId: any, tenantId: any) {
        let result =  await getManager()
            .createQueryBuilder(Room, 'room')
            .select(['*'])
            .innerJoin(RoomGroup, 'room_group', 'room.room_group_id = room_group.room_group_id')
            .innerJoin(Building, 'building', 'room_group.building_id = building.building_id')
            .leftJoin(Transaction, 'transaction', 'room.room_id = transaction.room_id')
            .leftJoin(User, 'user', 'transaction.user_id = user.user_id')
            .where('building.host_id = :host_id', {host_id: hostId})
            .andWhere('transaction.user_id = :tenant_id', {tenant_id: tenantId})
            .andWhere('transaction.transaction_status = :transferred', {transferred: ConstantValues.HOST_DEPOSIT_TRANSFERRED})
            .andWhere('room.room_status <> :deleted', { deleted: ConstantValues.ROOM_WAS_DELETED })
            .getRawMany();
        return (result.length > 0);
    }

    async isCheckedOutHostAndTenant(hostId: any, tenantId: any) {
        let result =  await getManager()
            .createQueryBuilder(Room, 'room')
            .select(['*'])
            .innerJoin(RoomGroup, 'room_group', 'room.room_group_id = room_group.room_group_id')
            .innerJoin(Building, 'building', 'room_group.building_id = building.building_id')
            .leftJoin(Transaction, 'transaction', 'room.room_id = transaction.room_id')
            .leftJoin(User, 'user', 'transaction.user_id = user.user_id')
            .where('building.host_id = :host_id', {host_id: hostId})
            .andWhere('transaction.user_id = :tenant_id', {tenant_id: tenantId})
            .andWhere('transaction.transaction_status = :checkedOut', {checkedOut: ConstantValues.CHECKED_OUT})
            .andWhere('room.room_status <> :deleted', { deleted: ConstantValues.ROOM_WAS_DELETED })
            .getRawMany();
        return (result.length > 0);
    }

    async getHostReviewOfTenant(tenantId: any) {
        console.log(await getManager()
            .createQueryBuilder(HostReview, 'host_review')
            .select(['user.first_name. user.last_name, user.avatar, host_review.comment'])
            .innerJoin(User, 'user', 'host_review.host_id = user.user_id')
            .where('host_review.tenant_id = :tenantId', {tenantId: tenantId})
            .getSql());
        return await getManager()
            .createQueryBuilder(HostReview, 'host_review')
            .select(['host_review.review_id, host_review.host_id, host_review.tenant_id, user.first_name' +
            ', user.last_name, user.avatar, host_review.comment'])
            .innerJoin(User, 'user', 'host_review.host_id = user.user_id')
            .where('host_review.tenant_id = :tenantId', {tenantId: tenantId})
            .getRawMany();
    }

}
