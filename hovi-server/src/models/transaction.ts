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
import {Room} from "./room";
import {RoomGroup} from "./room-group";
import {Building} from "./building";
import {Amenities} from "./amenities";
import {RoomAmenities} from "./room-amenities";
import {ConstantValues} from "../utils/constant-values";

@Entity(Transaction.tableName)
export class Transaction extends BaseEntity {
    static readonly tableName = 'transaction';
    static readonly schema = {
        transactionId: 'transaction_id',
        userId: 'user_id',
        roomId: 'room_id',
        transactionStatus: 'transaction_status',
        createAt: 'created_at',
        updateAt: 'updated_at'
    };

    @PrimaryColumn({
        type: "int",
        generated: true,
        unsigned: true,
        name: Transaction.schema.transactionId
    })
    transactionId: number;

    @ManyToOne(type => User, user => user.transactions)
    @JoinColumn({name: Transaction.schema.userId})
    user: User;
    @Column({name: Transaction.schema.userId})
    userId: number;


    @ManyToOne(type => Room, room => room.transactions)
    @JoinColumn({name: Transaction.schema.roomId})
    room: Room;
    @Column({name: Transaction.schema.roomId})
    roomId: number;

    @Column({
        type: "tinyint",
        unique: false,
        name: Transaction.schema.transactionStatus
    })
    transactionStatus: number;

    @CreateDateColumn({
        type: "timestamp",
        precision: 6,
        default: () => "CURRENT_TIMESTAMP(6)",
        onUpdate: "CURRENT_TIMESTAMP(6)",
        name: Transaction.schema.createAt
    })
    createAt: Date;

    @UpdateDateColumn({
        type: "timestamp",
        precision: 6,
        default: () => "CURRENT_TIMESTAMP(6)",
        onUpdate: "CURRENT_TIMESTAMP(6)",
        name: Transaction.schema.updateAt
    })
    updateAt: Date;

    static get repo(): TransactionRepository {
        return getCustomRepository(TransactionRepository);
    }
}

@EntityRepository(Transaction)
export class TransactionRepository extends Repository<Transaction> {
    async updateById(transactionId: any, transactionUpdate: Transaction) {
        let transaction = await this.findOne(transactionId);
        if (transaction) {
            transaction.userId = transactionUpdate.userId ;
            transaction.roomId = transactionUpdate.roomId;
            transaction.transactionStatus = transactionUpdate.transactionStatus ;
            transaction.createAt = transactionUpdate.createAt;
            transaction.updateAt = transactionUpdate.updateAt;
            await this.save(transaction);
        }
        return transaction;
    }


    async getTenantId(transactionId: any) {
        let transaction = await this.findOne(transactionId);
        return transaction.userId;
    }

    async getTransaction(userId: any, roomId: any) {
        return await this.find({userId: userId, roomId: roomId});
    }

    async getTransactionRoomDetail(transactionId: any) {
        let transaction = await this.findOne(transactionId);
        if (transaction == null) {
            return null;
        }
        //console.log('trans id: ' + transaction.transactionId);
        return await getManager()
            .createQueryBuilder(Transaction, 'transaction')
            .select(['*'])
            .innerJoin(Room, 'room', 'room.room_id = transaction.room_id')
            .innerJoin(RoomGroup, 'room_group', 'room.room_group_id = room_group.room_group_id')
            .innerJoin(Building, 'building', 'building.building_id = room_group.building_id')
            .innerJoin(User, 'user', 'user.user_id = building.host_id')
            .where('transaction.transaction_id = :transactionId', { transactionId: transactionId })
            .andWhere('room.room_id = :roomId', {roomId: transaction.roomId})
            .getRawMany();
    }

    async getTransactionStatus(roomGroupId: number, userId: number) {
        const query = await getManager()
            .createQueryBuilder(Transaction, 'transaction')
            .select(['*'])
            .innerJoin(Room, 'room', 'room.room_id = transaction.room_id')
            .where('room.room_group_id = :room_group_id', { room_group_id: roomGroupId })
            .andWhere('transaction.user_id = :user_id', {user_id: userId})
            .getSql();
        //console.log(query);
        return await getManager()
            .createQueryBuilder(Transaction, 'transaction')
            .select(['*'])
            .innerJoin(Room, 'room', 'room.room_id = transaction.room_id')
            .innerJoin(User, 'user', 'transaction.user_id = user.user_id')
            .where('room.room_group_id = :room_group_id', { room_group_id: roomGroupId })
            .andWhere('transaction.user_id = :user_id', {user_id: userId})
            .getRawMany();
    }

    async getTransactionStatusForHost(roomGroupId: number) {
        const query = await getManager()
            .createQueryBuilder(Transaction, 'transaction')
            .select(['*'])
            .innerJoin(Room, 'room', 'room.room_id = transaction.room_id')
            .innerJoin(User, 'user', 'transaction.user_id = user.user_id')
            .where('room.room_group_id = :room_group_id', { room_group_id: roomGroupId })
            .andWhere('transaction.transaction_status <> :status', {status: ConstantValues.HOST_REJECTED})
            .getSql();
        console.log(query);
        return await getManager()
            .createQueryBuilder(Transaction, 'transaction')
            .select(['*'])
            .innerJoin(Room, 'room', 'room.room_id = transaction.room_id')
            .innerJoin(User, 'user', 'transaction.user_id = user.user_id')
            .where('room.room_group_id = :room_group_id', { room_group_id: roomGroupId })
            .andWhere('transaction.transaction_status <> :status', {status: ConstantValues.HOST_REJECTED})
            .getRawMany();
    }

}
