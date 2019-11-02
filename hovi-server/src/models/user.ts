import {
  BaseEntity,
  Unique,
  Column,
  Entity,
  EntityRepository, getCustomRepository,
  Repository,
  PrimaryColumn, JoinColumn, OneToMany,
} from 'typeorm';
import * as bcrypt from 'bcryptjs';
import { MaxLength, IsEmail, Length } from 'class-validator';
import { Building } from './building';
import { Transaction } from './transaction';
import { Feedback } from './feedback';
import {TenantReview} from "./tenant-review";
import {ConstantValues} from "../utils/constant-values";

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
    phoneToken: 'phone_token',
    roleAdmin: 'role_admin',
    gender: 'gender',
    facebookId: 'facebook_id',
    googleId: 'google_id',
    email: 'email',
    avatar: 'avatar',
    address: 'address',
    isPhoneNumberVerified: 'is_phone_number_verified',
    isSelfieVerified: 'is_selfie_verified',
    isGovernmentIdVerified: 'is_government_id_verified',
    isVerified: 'is_verified',
    isHost: 'is_host',
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
    length: 255,
    name: User.schema.phoneToken,
  })
  @MaxLength(255)
  phoneToken: string;

  @Column({
    type: 'varchar',
    length: 50,
    name: User.schema.roleAdmin,
  })
  roleAdmin: string;

  @Column({
    type: 'boolean',
    name: User.schema.gender,
  })
  gender: boolean;

  @Column({
    type: 'varchar',
    length: 255,
    name: User.schema.facebookId,
  })
  @MaxLength(255)
  facebookId: string;

  @Column({
    type: 'varchar',
    length: 255,
    name: User.schema.googleId,
  })
  @MaxLength(255)
  googleId: string;

  @Column({
    type: 'varchar',
    length: 255,
    unique: true,
    name: User.schema.email,
  })
  @MaxLength(255)
  @IsEmail()
  email: string;

  @Column({
    type: 'text',
    name: User.schema.avatar,
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
    type: 'boolean',
    unique: false,
    name: User.schema.isPhoneNumberVerified,
  })
  isPhoneNumberVerified: boolean;

  @Column({
    type: 'boolean',
    unique: false,
    name: User.schema.isSelfieVerified,
  })
  isSelfieVerified: boolean;

  @Column({
    type: 'boolean',
    unique: false,
    name: User.schema.isGovernmentIdVerified,
  })
  isGovernmentIdVerified: boolean;

  @Column({
    type: 'boolean',
    unique: false,
    name: User.schema.isVerified,
  })
  isVerified: boolean;

  @Column({
    type: 'boolean',
    unique: false,
    name: User.schema.isHost,
  })
  isHost: boolean;

  @Column({
    type: 'boolean',
    unique: false,
    name: User.schema.isActive,
  })
  isActive: boolean;

  @Column({
    type: 'double',
    unique: false,
    name: User.schema.balance,
  })
  balance: number;

  @Column({
    type: 'timestamp',
    precision: 6,
    default: () => 'CURRENT_TIMESTAMP(6)',
    onUpdate: 'CURRENT_TIMESTAMP(6)',
    name: User.schema.createdAt,
  })
  createdAt: Date;

  @Column({
    type: 'timestamp',
    precision: 6,
    default: () => 'CURRENT_TIMESTAMP(6)',
    onUpdate: 'CURRENT_TIMESTAMP(6)',
    name: User.schema.updatedAt,
  })
  updatedAt: Date;

  @OneToMany(type => Building, building => building.host)
  @JoinColumn({ name: User.schema.id })
  buildings: Building[];

  @OneToMany(type => Transaction, transaction => transaction.user)
  @JoinColumn({ name: User.schema.id })
  transactions: Transaction[];

  @OneToMany(type => Feedback, transaction => transaction.user)
  @JoinColumn({ name: User.schema.id })
  feedbacks: Feedback[];

  @OneToMany(type => TenantReview, tenantReview => tenantReview.user)
  @JoinColumn({ name: User.schema.id })
  tenantReviews: TenantReview[];

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
      user.firstName = userUpdate.firstName ? userUpdate.firstName : user.firstName;
      user.lastName = userUpdate.lastName ? userUpdate.lastName : user.lastName;
      user.phoneNumber = userUpdate.phoneNumber ? userUpdate.phoneNumber : user.phoneNumber;
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
      user.balance = userUpdate.balance ? userUpdate.balance : user.balance;
      await this.save(user);
    }
    return user;
  }

  async verifyPhoneNumber(phoneNumber: string, verifyId: string) {
    let user = await this.findOne({phoneNumber: phoneNumber});
    if (user.phoneToken === verifyId) {
      user.phoneToken = '';
      await this.save(user);
    }
    return user;
  }

  async getHostPhone(userId: number) {
    let user = await this.findOne({id: userId});
    return user.phoneNumber;
  }

  async getUserDetail(userId: any) {
    const user = await this.findOne({id: userId});
    if (user == null) {
      return null;
    }
    const result = {
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
          isVerified: (user.email != ConstantValues.DEFAULT_EMAIL) ? true : false
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
    }
    return result;
  }
}
