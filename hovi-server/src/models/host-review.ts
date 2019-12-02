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
    @Column({name: HostReview.schema.hostId})
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

}
