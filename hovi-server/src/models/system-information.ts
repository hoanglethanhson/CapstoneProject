import {
    BaseEntity,
    Column,
    Entity,
    EntityRepository, getCustomRepository,
    Repository,
    PrimaryColumn, ManyToOne, JoinColumn, OneToMany, Not, LessThan, getConnection,
} from 'typeorm';
import { ConstantValues } from '../utils/constant-values';

@Entity(SystemInformation.tableName)
export class SystemInformation extends BaseEntity {
    static readonly tableName = 'system_information';
    static readonly schema = {
        info_id: 'info_id',
        title: 'title',
        content: 'content',
        createdAt: 'created_at',
        updatedAt: 'updated_at',
    };

    @PrimaryColumn({
        type: 'int',
        generated: true,
        unsigned: true,
        name: SystemInformation.schema.info_id,
    })
    info_id: number;

    @Column({
        type: 'varchar',
        length: 255,
        name: SystemInformation.schema.title,
    })
    title: string;

    @Column({
        type: 'text',
        name: SystemInformation.schema.content,
    })
    content: string;

    @Column({
        type: 'timestamp',
        name: SystemInformation.schema.createdAt,
    })
    createdAt: Date;

    @Column({
        type: 'timestamp',
        name: SystemInformation.schema.updatedAt,
    })
    updatedAt: Date;


    static get repo(): SystemInformationRepository {
        return getCustomRepository(SystemInformationRepository);
    }
}

@EntityRepository(SystemInformation)
export class SystemInformationRepository extends Repository<SystemInformation> {
    async updateById(systemInformationId: any, systemInformationUpdate: any) {
        let systemInformation = await this.findOne(systemInformationId);
        if (systemInformation) {
            systemInformation.title = systemInformationUpdate.title;
            systemInformation.content = systemInformationUpdate.content;
            await this.save(systemInformation);
        }
        return systemInformation;
    }

}
