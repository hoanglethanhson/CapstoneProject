import {
    BaseEntity,
    Column,
    Entity,
    EntityRepository, getCustomRepository,
    Repository,
    PrimaryColumn, ManyToOne, JoinColumn,
} from 'typeorm';
import {IsEmail, MaxLength} from "class-validator";
import {User} from "./user";

@Entity(Feedback.tableName)
export class Feedback extends BaseEntity {
    static readonly tableName = 'feedback';
    static readonly schema = {
        feedbackId: 'feedback_id',
        userId: 'user_id',
        email: 'email',
        content: 'content',
        createAt: 'created_at',
        updateAt: 'updated_at'
    };

    @PrimaryColumn({
        type: "int",
        generated: true,
        unsigned: true,
        name: Feedback.schema.feedbackId
    })
    feedbackId: number;

    @ManyToOne(type => User, user => user.feedbacks)
    @JoinColumn({name: Feedback.schema.userId})
    user: User;
    @Column({name: Feedback.schema.userId})
    userId: number;

    @Column({
        type: "varchar",
        //length: 1000,
        unique: true,
        nullable: true,
        name: Feedback.schema.email,
    })
    //@MaxLength(1000)
    //@IsEmail()
    email: string;

    @Column({
        type: "text",
        unique: false,
        name: Feedback.schema.content
    })
    content: string;

    @Column({
        type: "timestamp",
        name: Feedback.schema.createAt
    })
    createAt: Date;

    @Column({
        type: "timestamp",
        name: Feedback.schema.updateAt
    })
    updateAt: Date;

    static get repo(): FeedbackRepository {
        return getCustomRepository(FeedbackRepository);
    }
}

@EntityRepository(Feedback)
export class FeedbackRepository extends Repository<Feedback> {
    async updateById(feedbackId: any, feedbackUpdate: Feedback) {
        let feedback = await this.findOne(feedbackId);
        if (feedback) {
            feedback.userId = feedbackUpdate.userId ? feedbackUpdate.userId : feedback.userId;
            feedback.email = feedbackUpdate.email ? feedbackUpdate.email : feedback.email;
            feedback.content = feedbackUpdate.content ? feedbackUpdate.content : feedback.content;
            feedback.createAt = feedbackUpdate.createAt ? feedbackUpdate.createAt : feedback.createAt;
            feedback.updateAt = feedbackUpdate.updateAt ? feedbackUpdate.updateAt : feedback.updateAt;
            await this.save(feedback);
        }
        return feedback;
    }
}
