import {
    BaseEntity,
    Unique,
    Column,
    Entity,
    EntityRepository, getCustomRepository,
    Repository,
    PrimaryColumn, ManyToOne, JoinColumn, OneToMany
} from 'typeorm';
import {MaxLength, IsEmail, Length} from 'class-validator';
import {Building} from "./building";
import {Transaction} from "./transaction";
import {Feedback} from "./feedback";

@Entity(User.tableName)
@Unique(["phone"])
export class User extends BaseEntity {
    static readonly tableName = 'user';
    static readonly schema = {
        id: 'user_id',
        firstName: 'first_name',
        lastName: 'last_name',
        phone: 'phone',
        phoneToken: 'phone_token',
        gender: 'gender',
        facebookId: 'facebook_id',
        googleId: 'google_id',
        email: 'email',
        avatar: 'avatar',
        address: 'address',
        isVerified: 'is_verified',
        isHost: 'is_host',
        isActive: 'is_active',
        create: 'created_at',
        update: 'updated_at'
    };

    @PrimaryColumn({
        type: "int",
        generated: true,
        unsigned: true,
        name: User.schema.id
    })
    id: number;

    @Column({
        type: "varchar",
        length: 255,
        unique: false,
        name: User.schema.firstName,
    })
    @Length(1, 255)
    firstName: string;

    @Column({
        type: "varchar",
        length: 255,
        unique: false,
        name: User.schema.lastName,
    })
    @Length(1, 255)
    lastName: string;

    @Column({
        type: "varchar",
        length: 20,
        unique: true,
        name: User.schema.phone,
    })
    @MaxLength(20)
    phone: string;

    @Column({
        type: "varchar",
        length: 1000,
        unique: true,
        name: User.schema.phoneToken,
    })
    @MaxLength(1000)
    phoneToken: string;

    @Column({
        type: "bit",
        unique: false,
        name: User.schema.gender,
    })
    gender: boolean;


    @Column({
        type: "varchar",
        length: 1000,
        name: User.schema.facebookId,
    })
    @MaxLength(1000)
    facebookId: string;

    @Column({
        type: "varchar",
        length: 1000,
        name: User.schema.googleId,
    })
    @MaxLength(1000)
    googleId: string;

    @Column({
        type: "varchar",
        length: 1000,
        unique: true,
        name: User.schema.email,
    })
    @MaxLength(1000)
    @IsEmail()
    email: string;

    @Column({
        type: "text",
        name: User.schema.avatar,
    })
    avatar: string;

    @Column({
        type: "varchar",
        length: 1000,
        name: User.schema.address,
    })
    @MaxLength(1000)
    address: string;

    @Column({
        type: "bit",
        unique: false,
        name: User.schema.isVerified,
    })
    isVerified: boolean;

    @Column({
        type: "bit",
        unique: false,
        name: User.schema.isHost,
    })
    isHost: boolean;

    @Column({
        type: "bit",
        unique: false,
        name: User.schema.isActive,
    })
    isActive: boolean;

    @Column({
        type: "timestamp",
        precision: 6,
        default: () => "CURRENT_TIMESTAMP(6)",
        onUpdate: "CURRENT_TIMESTAMP(6)",
        name: User.schema.create
    })
    create: Date;

    @Column({
        type: "timestamp",
        precision: 6,
        default: () => "CURRENT_TIMESTAMP(6)",
        onUpdate: "CURRENT_TIMESTAMP(6)",
        name: User.schema.update
    })
    update: Date;

    @OneToMany(type => Building, building => building.host)
    @JoinColumn({name: User.schema.id})
    buildings: Building[];

    @OneToMany(type => Transaction, transaction => transaction.user)
    @JoinColumn({name: User.schema.id})
    transactions: Transaction[];

    feedbacks: Feedback[];

    static get repo(): UserRepository {
        return getCustomRepository(UserRepository);
    }
}

@EntityRepository(User)
export class UserRepository extends Repository<User> {
    async updateById(userId: any, userUpdate: User) {
        let user = await this.findOne(userId);
        if (user) {
            user.firstName = userUpdate.firstName ? userUpdate.firstName : user.firstName;
            user.lastName = userUpdate.lastName ? userUpdate.lastName : user.lastName;
            user.phone = userUpdate.phone ? userUpdate.phone : user.phone;
            user.phoneToken = userUpdate.phoneToken ? userUpdate.phoneToken : user.phoneToken;
            user.gender = userUpdate.gender ? userUpdate.gender : user.gender;
            user.facebookId = userUpdate.facebookId ? userUpdate.facebookId : user.facebookId;
            user.googleId = userUpdate.googleId ? userUpdate.googleId : user.googleId;
            user.avatar = userUpdate.avatar ? userUpdate.avatar : user.avatar;
            user.address = userUpdate.address ? userUpdate.address : user.address;
            user.email = userUpdate.email ? userUpdate.email : user.email;
            user.isVerified = userUpdate.isVerified ? userUpdate.isVerified : user.isVerified;
            user.isHost = userUpdate.isHost ? userUpdate.isHost : user.isHost;
            user.isActive = userUpdate.isActive ? userUpdate.isActive : user.isActive;
            user.create = userUpdate.create ? userUpdate.create : user.create;
            user.update = userUpdate.update ? userUpdate.update : user.update;
            await this.save(user);
        }
        return user;
    }
}
