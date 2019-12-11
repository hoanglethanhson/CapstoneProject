import {
    BaseEntity,
    Column,
    Entity,
    EntityRepository,
    getCustomRepository,
    JoinColumn,
    OneToMany,
    PrimaryColumn,
    Repository,
    Unique,
} from 'typeorm';
import * as bcrypt from 'bcryptjs';
import {IsEmail, IsPhoneNumber, Length, MaxLength} from 'class-validator';
import {Building} from './building';
import {Transaction} from './transaction';
import {Feedback} from './feedback';
import {TenantReview} from "./tenant-review";
import {ConstantValues} from "../utils/constant-values";
import {BankTransferHistory} from "./bank-transfer-history";
import {ReportedRoom} from "./reported-room";
import {Room} from "./room";
import {RoomGroup} from "./room-group";
import {SavedRoom} from "./saved-room";
import {HostReview} from "./host-review";

@Entity(User.tableName)
@Unique(['phoneNumber'])
export class User extends BaseEntity {
    static readonly tableName = 'user';
    static readonly schema = {
        id: 'user_id',
        firstName: 'first_name',
        lastName: 'last_name',
        phoneNumber: 'phone_number',
        password: 'password',
        roleAdmin: 'role_admin',
        gender: 'gender',
        email: 'email',
        avatar: 'avatar',
        address: 'address',
        idCardFront: 'id_card_front',
        idCardBack: 'id_card_back',
        selfieImage: 'selfie_image',
        isEmailVerified: 'is_email_verified',
        isPhoneNumberVerified: 'is_phone_number_verified',
        isSelfieVerified: 'is_selfie_verified',
        isGovernmentIdVerified: 'is_government_id_verified',
        isActive: 'is_active',
        balance: 'balance',
        createdAt: 'created_at',
        updatedAt: 'updated_at',
    };

    @PrimaryColumn({
        type: 'int',
        generated: true,
        unsigned: true,
        name: User.schema.id,
    })
    id: number;

    @Column({
        type: 'varchar',
        length: 255,
        name: User.schema.firstName,
    })
    @Length(1, 255)
    firstName: string;

    @Column({
        type: 'varchar',
        length: 255,
        name: User.schema.lastName,
    })
    @Length(1, 255)
    lastName: string;

    @Column({
        type: 'varchar',
        length: 20,
        unique: true,
        name: User.schema.phoneNumber,
    })
    @MaxLength(20)
    @IsPhoneNumber('VN', {
        message: 'Số điện thoại của bạn không hợp lệ'
    })
    phoneNumber: string;

    @Column({
        type: 'varchar',
        length: 255,
        name: User.schema.password,
    })
    @Length(4, 255)
    password: string;

    @Column({
        type: 'varchar',
        length: 50,
        name: User.schema.roleAdmin,
    })
    roleAdmin: string;

    @Column({
        type: 'tinyint',
        name: User.schema.gender,
    })
    gender: number;

    @Column({
        type: 'varchar',
        length: 255,
        unique: true,
        name: User.schema.email,
        nullable: true
    })
    @MaxLength(255)
    @IsEmail()
    email: string;

    @Column({
        type: 'text',
        name: User.schema.avatar,
        default: ConstantValues.DEFAULT_AVATAR,
    })
    avatar: string;

    @Column({
        type: 'varchar',
        length: 255,
        name: User.schema.address,
    })
    @MaxLength(255)
    address: string;

    @Column({
        type: 'text',
        name: User.schema.idCardFront,
    })
    idCardFront: string;

    @Column({
        type: 'text',
        name: User.schema.idCardBack,
    })
    idCardBack: string;

    @Column({
        type: 'text',
        name: User.schema.selfieImage,
    })
    selfieImage: string;

    @Column({
        type: 'boolean',
        name: User.schema.isEmailVerified,
    })
    isEmailVerified: boolean;

    @Column({
        type: 'boolean',
        name: User.schema.isPhoneNumberVerified,
    })
    isPhoneNumberVerified: boolean;

    @Column({
        type: 'boolean',
        name: User.schema.isSelfieVerified,
    })
    isSelfieVerified: boolean;

    @Column({
        type: 'boolean',
        name: User.schema.isGovernmentIdVerified,
    })
    isGovernmentIdVerified: boolean;

    @Column({
        type: 'boolean',
        name: User.schema.isActive,
        default: 1
    })
    isActive: boolean;

    @Column({
        type: 'double',
        name: User.schema.balance,
        default: 0
    })
    balance: number;

    @Column({
        type: 'timestamp',
        name: User.schema.createdAt,
    })
    createdAt: Date;

    @Column({
        type: 'timestamp',
        name: User.schema.updatedAt,
    })
    updatedAt: Date;

    @OneToMany(type => Building, building => building.host)
    @JoinColumn({name: User.schema.id})
    buildings: Building[];

    @OneToMany(type => Transaction, transaction => transaction.user)
    @JoinColumn({name: User.schema.id})
    transactions: Transaction[];

    @OneToMany(type => Feedback, transaction => transaction.user)
    @JoinColumn({name: User.schema.id})
    feedbacks: Feedback[];

    @OneToMany(type => TenantReview, tenantReview => tenantReview.user)
    @JoinColumn({name: User.schema.id})
    tenantReviews: TenantReview[];

    @OneToMany(type => BankTransferHistory, bankTransferHistory => bankTransferHistory.sender)
    @JoinColumn({name: User.schema.id})
    bankTransferHistorySenders: BankTransferHistory[];

    @OneToMany(type => BankTransferHistory, bankTransferHistory => bankTransferHistory.receiver)
    @JoinColumn({name: User.schema.id})
    bankTransferHistoryReceivers: BankTransferHistory[];

    @OneToMany(type => ReportedRoom, reportedRoom => reportedRoom.user)
    @JoinColumn({name: User.schema.id})
    reportedRooms: ReportedRoom[];

    @OneToMany(type => SavedRoom, savedRoom => savedRoom.user)
    @JoinColumn({name: User.schema.id})
    savedRooms: SavedRoom[];

    @OneToMany(type => HostReview, hostReview => hostReview.host)
    @JoinColumn({name: User.schema.id})
    hosts: SavedRoom[];

    @OneToMany(type => HostReview, hostReview => hostReview.tenant)
    @JoinColumn({name: User.schema.id})
    tenants: SavedRoom[];

    checkIfUnencryptedPasswordIsValid(unencryptedPassword: string) {
        return bcrypt.compareSync(unencryptedPassword, this.password);
    }

    static get repo(): UserRepository {
        return getCustomRepository(UserRepository);
    }
}

@EntityRepository(User)
export class UserRepository extends Repository<User> {
    async updateById(userId: any, userUpdate: User) {
        let user = await this.findOne(userId);
        if (user) {
            user.gender = userUpdate.gender ? userUpdate.gender : user.gender;
            user.address = userUpdate.address ? userUpdate.address : user.address;
            user.idCardFront = userUpdate.idCardFront ? userUpdate.idCardFront : user.idCardFront;
            user.idCardBack = userUpdate.idCardBack ? userUpdate.idCardBack : user.idCardBack;
            user.selfieImage = userUpdate.selfieImage ? userUpdate.selfieImage : user.selfieImage;
            user.isEmailVerified = typeof userUpdate.isEmailVerified === 'boolean' ? userUpdate.isEmailVerified : user.isEmailVerified;
            user.isPhoneNumberVerified = typeof userUpdate.isPhoneNumberVerified === 'boolean' ? userUpdate.isPhoneNumberVerified : user.isPhoneNumberVerified;
            user.isGovernmentIdVerified = typeof userUpdate.isGovernmentIdVerified === 'boolean' ? userUpdate.isGovernmentIdVerified : user.isGovernmentIdVerified;
            user.isSelfieVerified = typeof userUpdate.isSelfieVerified === 'boolean' ? userUpdate.isSelfieVerified : user.isSelfieVerified;
            user.isActive = typeof userUpdate.isActive === 'boolean' ? userUpdate.isActive : user.isActive;
            user.balance = userUpdate.balance ? userUpdate.balance : user.balance;
            await this.save(user);
        }
        return user;
    }

    async updateUserInformationById(userId: any, userUpdate: User) {
        let user = await this.findOne(userId);
        let oldEmail = user.email;
        if (user) {
            user.firstName = userUpdate.firstName ? userUpdate.firstName : user.firstName;
            user.lastName = userUpdate.lastName ? userUpdate.lastName : user.lastName;
            user.gender = userUpdate.gender;
            user.address = userUpdate.address ? userUpdate.address : user.address;
            user.email = userUpdate.email ? userUpdate.email : user.email;
            await this.save(user);
        }

        return {...user, oldEmail, password: ''};
    }

    async updateUserImage(userId: any, typeImage: string, url: string) {
        let user = await this.findOne(userId);
        user[typeImage] = url;
        await this.save(user);
    }

    async getUserDetail(userId: any) {
        const user = await this.findOne({id: userId});
        if (user == null) {
            return null;
        }
        return {
            user_avatar: user.avatar,
            user_name: user.firstName + " " + user.lastName,
            user_address: user.address,
            verification: [
                {
                    name: 'Ảnh bản thân',
                    isVerified: user.isSelfieVerified
                },
                {
                    name: 'Địa chỉ email',
                    isVerified: user.isEmailVerified
                },
                {
                    name: 'Số điện thoại',
                    isVerified: user.isPhoneNumberVerified
                },
                {
                    name: 'Chứng minh nhân dân',
                    isVerified: user.isGovernmentIdVerified
                },
            ]
        };
    }

    async getUserSetting(userId: any) {
        const user = await this.findOne({id: userId});
        user.password = '';
        return user;
    }

    async isUserAuthorized(userId: any, transactionId: any) {
        const transaction = await Transaction.repo.findOne(transactionId);
        const room = await Room.repo.findOne(transaction.roomId);
        const roomGroup = await RoomGroup.repo.findOne(room.roomGroupId);
        const building = await Building.repo.findOne(roomGroup.buildingId);
        return !(building.hostId != parseInt(userId) && transaction.userId != parseInt(userId));
    }

    async isTenantAuthorized(userId: any, transactionId: any) {
        const transaction = await Transaction.repo.findOne(transactionId);
        return transaction.userId == parseInt(userId);
    }

    async isHostAuthorized(userId: any, transactionId: any) {
        const transaction = await Transaction.repo.findOne(transactionId);
        const room = await Room.repo.findOne(transaction.roomId);
        const roomGroup = await RoomGroup.repo.findOne(room.roomGroupId);
        const building = await Building.repo.findOne(roomGroup.buildingId);
        return building.hostId == parseInt(userId);
    }

    async verifyPhoneNumber(phoneNumber: string) {
        let user = await this.findOne({phoneNumber});
        user.isPhoneNumberVerified = true;
        await this.save(user);
    }
}
