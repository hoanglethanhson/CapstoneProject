import {
    BaseEntity,
    Unique,
    Column,
    Entity,
    EntityRepository, getCustomRepository,
    Repository,
    PrimaryColumn
} from 'typeorm';
import {MaxLength, IsEmail, IsPhoneNumber, Length} from 'class-validator';

@Entity(User.tableName)
@Unique(["userName"])
export class User extends BaseEntity {
    static readonly tableName = 'user';
    static readonly schema = {
        id: 'id',
        userName: 'userName',
        fullName: 'full_name',
        phoneNumber: 'phone_number',
        email: 'email'
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
        length: 50,
        unique: true,
        name: User.schema.userName,
    })
    @Length(4, 100)
    userName: string;

    @Column({
        type: "varchar",
        length: 50,
        name: User.schema.fullName,
    })
    @MaxLength(50)
    fullName: string;

    @Column({
        type: "varchar",
        length: 24,
        unique: true,
        name: User.schema.phoneNumber,
    })
    @MaxLength(24)
    @IsPhoneNumber('VN', {
        message: "Invalid phone number"
    })
    phoneNumber: string;

    @Column({
        type: "varchar",
        length: 24,
        unique: true,
        name: User.schema.email,
    })
    @MaxLength(24)
    @IsEmail()
    email: string;

    static get repo(): UserRepository {
        return getCustomRepository(UserRepository);
    }
}

@EntityRepository(User)
export class UserRepository extends Repository<User> {
    async updateById(userId: any, userUpdate: User) {
        let user = await this.findOne(userId);
        if (user) {
            user.fullName = userUpdate.fullName ? userUpdate.fullName : user.fullName;
            user.phoneNumber = userUpdate.phoneNumber ? userUpdate.phoneNumber : user.phoneNumber;
            user.email = userUpdate.email ? userUpdate.email : user.email;
            await this.save(user);
        }
        return user;
    }
}
