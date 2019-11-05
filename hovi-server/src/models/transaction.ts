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
    UpdateDateColumn
} from 'typeorm';
import {User} from "./user";
import {Room} from "./room";
import {BankTransferHistory} from "./bank-transfer-history";

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
}
