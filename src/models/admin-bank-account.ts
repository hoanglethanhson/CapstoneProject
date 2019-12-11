import {
    BaseEntity,
    Column,
    Entity,
    EntityRepository, getCustomRepository,
    Repository,
    PrimaryColumn, ManyToOne, JoinColumn, OneToMany, Not, LessThan, getConnection,
} from 'typeorm';
import { ConstantValues } from '../utils/constant-values';

@Entity(AdminBankAccount.tableName)
export class AdminBankAccount extends BaseEntity {
    static readonly tableName = 'admin_bank_account';
    static readonly schema = {
        accountId: 'account_id',
        bank: 'bank',
        accountNumber: 'account_number',
        holderName: 'holder_name',
        createdAt: 'created_at',
        updatedAt: 'updated_at',
    };

    @PrimaryColumn({
        type: 'int',
        generated: true,
        unsigned: true,
        name: AdminBankAccount.schema.accountId,
    })
    accountId: number;

    @Column({
        type: 'varchar',
        length: 255,
        name: AdminBankAccount.schema.bank,
    })
    bank: string;

    @Column({
        type: 'varchar',
        length: 255,
        name: AdminBankAccount.schema.accountNumber,
    })
    accountNumber: string;

    @Column({
        type: 'varchar',
        length: 255,
        name: AdminBankAccount.schema.holderName,
    })
    holderName: string;


    @Column({
        type: 'timestamp',
        name: AdminBankAccount.schema.createdAt,
    })
    createdAt: Date;

    @Column({
        type: 'timestamp',
        name: AdminBankAccount.schema.updatedAt,
    })
    updatedAt: Date;


    static get repo(): AdminBankAccountRepository {
        return getCustomRepository(AdminBankAccountRepository);
    }
}

@EntityRepository(AdminBankAccount)
export class AdminBankAccountRepository extends Repository<AdminBankAccount> {
    async updateById(adminBankAccountId: any, adminBankAccountUpdate: any) {
        let adminBankAccount = await this.findOne(adminBankAccountId);
        if (adminBankAccount) {
            adminBankAccount.bank = adminBankAccountUpdate.bank;
            adminBankAccount.accountNumber = adminBankAccountUpdate.accountNumber;
            adminBankAccount.holderName = adminBankAccountUpdate.holderName;
            await this.save(adminBankAccount);
        }
        return adminBankAccount;
    }
    
}
