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
    UpdateDateColumn, getManager
} from 'typeorm';
import {User} from "./user";
import {RoomGroup} from "./room-group";

@Entity(TenantReview.tableName)
export class TenantReview extends BaseEntity {
    static readonly tableName = 'tenant_review';
    static readonly schema = {
        reviewId: 'review_id',
        userId: 'user_id',
        roomGroupId: 'room_group_id',
        comment: 'comment',
        accuracyStar: 'accuracy_star',
        hostStar: 'host_star',
        securityStar: 'security_star',
        createAt: 'created_at',
        updateAt: 'updated_at'
    };

    @PrimaryColumn({
        type: "int",
        generated: true,
        unsigned: true,
        name: TenantReview.schema.reviewId
    })
    reviewId: number;

    @ManyToOne(type => User, user => user.tenantReviews)
    @JoinColumn({name: TenantReview.schema.userId})
    user: User;
    @Column({name: TenantReview.schema.userId})
    userId: number;


    @ManyToOne(type => RoomGroup, roomGroup => roomGroup.tenantReviews)
    @JoinColumn({name: TenantReview.schema.roomGroupId})
    roomGroup: RoomGroup;
    @Column({name: TenantReview.schema.roomGroupId})
    roomGroupId: number;

    @Column({
        type: "text",
        unique: false,
        name: TenantReview.schema.comment
    })
    comment: string;

    @Column({
        type: "int",
        unique: false,
        name: TenantReview.schema.accuracyStar
    })
    accuracyStar: number;

    @Column({
        type: "int",
        unique: false,
        name: TenantReview.schema.hostStar
    })
    hostStar: number;

    @Column({
        type: "int",
        unique: false,
        name: TenantReview.schema.securityStar
    })
    securityStar: number;

    @CreateDateColumn({
        type: "timestamp",
        precision: 6,
        default: () => "CURRENT_TIMESTAMP(6)",
        onUpdate: "CURRENT_TIMESTAMP(6)",
        name: TenantReview.schema.createAt
    })
    createAt: Date;

    @UpdateDateColumn({
        type: "timestamp",
        precision: 6,
        default: () => "CURRENT_TIMESTAMP(6)",
        onUpdate: "CURRENT_TIMESTAMP(6)",
        name: TenantReview.schema.updateAt
    })
    updateAt: Date;


    static get repo(): TenantReviewRepository {
        return getCustomRepository(TenantReviewRepository);
    }
}

@EntityRepository(TenantReview)
export class TenantReviewRepository extends Repository<TenantReview> {
    async updateById(tenantReviewId: any, tenantReviewUpdate: TenantReview) {
        let tenantReview = await this.findOne(tenantReviewId);
        if (tenantReview) {
            tenantReview.userId = tenantReviewUpdate.userId ? tenantReviewUpdate.userId : tenantReview.userId;
            tenantReview.roomGroupId = tenantReviewUpdate.roomGroupId ? tenantReviewUpdate.roomGroupId : tenantReview.roomGroupId;
            tenantReview.comment = tenantReviewUpdate.comment ? tenantReviewUpdate.comment : tenantReview.comment;
            tenantReview.accuracyStar = tenantReviewUpdate.accuracyStar ? tenantReviewUpdate.accuracyStar : tenantReview.accuracyStar;
            tenantReview.hostStar = tenantReviewUpdate.hostStar ? tenantReviewUpdate.hostStar : tenantReview.hostStar;
            tenantReview.securityStar = tenantReviewUpdate.securityStar ? tenantReviewUpdate.securityStar : tenantReview.securityStar;
            tenantReview.createAt = tenantReviewUpdate.createAt ? tenantReviewUpdate.createAt : tenantReview.createAt;
            tenantReview.updateAt = tenantReviewUpdate.updateAt ? tenantReviewUpdate.updateAt : tenantReview.updateAt;
            await this.save(tenantReview);
        }
        return tenantReview;
    }

    async getRatingResult(roomGroupId: any) {
        return await this.manager.query("SELECT AVG(accuracy_star) as \'accuracy_rate\', AVG(host_star) as \'host_rate'\, " +
            "AVG(security_star) as \'security_rate\' FROM `tenant_review` WHERE room_group_id = ?",
            [roomGroupId]);
    }
}
