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
import {Transaction} from "./transaction";
import {MaxLength} from "class-validator";

@Entity(BankTransferHistory.tableName)
export class BankTransferHistory extends BaseEntity {
    static readonly tableName = 'bank_transfer_history';
    static readonly schema = {
        transferId: 'transfer_id',
        transactionId: 'transaction_id',
        senderUserId: 'sender_user_id',
        senderBank: 'sender_bank',
        senderAccountNumber: 'sender_account_number',
        senderUserType: 'sender_user_type',
        receiverUserId: 'receiver_user_id',
        receiverBank: 'receiver_bank',
        receiverAccountNumber: 'receiver_account_number',
        receiverUserType: 'receiver_user_type',
        transferTime: 'transfer_time',
        moneyAmount: 'money_amount',
        createAt: 'created_at',
        updateAt: 'updated_at'
    };

    @PrimaryColumn({
        type: "int",
        generated: true,
        unsigned: true,
        name: BankTransferHistory.schema.transferId
    })
    transferId: number;

    @ManyToOne(type => Transaction, transaction => transaction.bankTransferHistories)
    @JoinColumn({name: BankTransferHistory.schema.transactionId})
    transaction: Transaction;
    @Column({name: BankTransferHistory.schema.transactionId})
    transactionId: number;


    @ManyToOne(type => User, user => user.bankTransferHistorySenders)
    @JoinColumn({name: BankTransferHistory.schema.senderUserId})
    sender: User;
    @Column({name: BankTransferHistory.schema.senderUserId})
    senderUserId: number;

    @Column({
        type: 'varchar',
        length: 255,
        name: BankTransferHistory.schema.senderBank,
    })
    @MaxLength(255)
    senderBank: string;

    @Column({
        type: 'varchar',
        length: 255,
        name: BankTransferHistory.schema.senderAccountNumber,
    })
    @MaxLength(255)
    senderAccountNumber: string;

    @Column({
        type: 'tinyint',
        name: BankTransferHistory.schema.senderUserType,
    })
    senderUserType: string;

    @ManyToOne(type => User, user => user.bankTransferHistoryReceivers)
    @JoinColumn({name: BankTransferHistory.schema.receiverUserId})
    receiver: User;
    @Column({name: BankTransferHistory.schema.receiverUserId})
    receiverUserId: number;

    @Column({
        type: 'varchar',
        length: 255,
        name: BankTransferHistory.schema.receiverBank,
    })
    @MaxLength(255)
    receiverBank: string;

    @Column({
        type: 'varchar',
        length: 255,
        name: BankTransferHistory.schema.receiverAccountNumber,
    })
    @MaxLength(255)
    receiverAccountNumber: string;

    @Column({
        type: 'tinyint',
        name: BankTransferHistory.schema.receiverUserType,
    })
    receiverUserType: string;

    @Column({
        type: "timestamp",
        precision: 6,
        default: () => "CURRENT_TIMESTAMP(6)",
        onUpdate: "CURRENT_TIMESTAMP(6)",
        name: BankTransferHistory.schema.transferTime
    })
    transferTime: Date;

    @Column({
        type: 'double',
        name: BankTransferHistory.schema.moneyAmount,
    })
    moneyAmount: string;

    @CreateDateColumn({
        type: "timestamp",
        precision: 6,
        default: () => "CURRENT_TIMESTAMP(6)",
        onUpdate: "CURRENT_TIMESTAMP(6)",
        name: BankTransferHistory.schema.createAt
    })
    createAt: Date;

    @UpdateDateColumn({
        type: "timestamp",
        precision: 6,
        default: () => "CURRENT_TIMESTAMP(6)",
        onUpdate: "CURRENT_TIMESTAMP(6)",
        name: BankTransferHistory.schema.updateAt
    })
    updateAt: Date;


    static get repo(): BankTransferHistoryRepository {
        return getCustomRepository(BankTransferHistoryRepository);
    }
}

@EntityRepository(BankTransferHistory)
export class BankTransferHistoryRepository extends Repository<BankTransferHistory> {
    async updateById(bankTransferHistoryId: any,bankTransferHistoryUpdate: BankTransferHistory) {
        let bankTransferHistory = await this.findOne(bankTransferHistoryId);
        if (bankTransferHistory) {
            bankTransferHistory.transactionId = bankTransferHistoryUpdate.transactionId ? bankTransferHistoryUpdate.transactionId : bankTransferHistory.transactionId;
            bankTransferHistory.senderUserId = bankTransferHistoryUpdate.senderUserId ? bankTransferHistoryUpdate.senderUserId : bankTransferHistory.senderUserId;
            bankTransferHistory.senderBank = bankTransferHistoryUpdate.senderBank ? bankTransferHistoryUpdate.senderBank : bankTransferHistory.senderBank;
            bankTransferHistory.senderAccountNumber = bankTransferHistoryUpdate.senderAccountNumber ? bankTransferHistoryUpdate.senderAccountNumber : bankTransferHistory.senderAccountNumber;
            bankTransferHistory.senderUserType = bankTransferHistoryUpdate.senderUserType ? bankTransferHistoryUpdate.senderUserType : bankTransferHistory.senderUserType;
            bankTransferHistory.receiverUserId = bankTransferHistoryUpdate.receiverUserId ? bankTransferHistoryUpdate.receiverUserId : bankTransferHistory.receiverUserId;
            bankTransferHistory.receiverBank = bankTransferHistoryUpdate.receiverBank ? bankTransferHistoryUpdate.receiverBank : bankTransferHistory.receiverBank;
            bankTransferHistory.receiverAccountNumber = bankTransferHistoryUpdate.receiverAccountNumber ? bankTransferHistoryUpdate.receiverAccountNumber : bankTransferHistory.receiverAccountNumber;
            bankTransferHistory.receiverUserType = bankTransferHistoryUpdate.receiverUserType ? bankTransferHistoryUpdate.receiverUserType : bankTransferHistory.receiverUserType;
            bankTransferHistory.transferTime = bankTransferHistoryUpdate.transferTime ? bankTransferHistoryUpdate.transferTime : bankTransferHistory.transferTime;
            bankTransferHistory.moneyAmount = bankTransferHistoryUpdate.moneyAmount ? bankTransferHistoryUpdate.moneyAmount : bankTransferHistory.moneyAmount;
            bankTransferHistory.createAt = bankTransferHistoryUpdate.createAt ? bankTransferHistoryUpdate.createAt : bankTransferHistory.createAt;
            bankTransferHistory.updateAt = bankTransferHistoryUpdate.updateAt ? bankTransferHistoryUpdate.updateAt : bankTransferHistory.updateAt;
            await this.save(bankTransferHistory);
        }
        return bankTransferHistory;
    }

}
