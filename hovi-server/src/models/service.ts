import {
    BaseEntity,
    Unique,
    Column,
    Entity,
    EntityRepository, getCustomRepository,
    Repository,
    PrimaryColumn, Index, OneToMany, JoinColumn
} from 'typeorm';
import {BuildingService} from "./building_service";

@Entity(Service.tableName)
@Unique(["name"])
export class Service extends BaseEntity {
    static readonly tableName = 'service';
    static readonly schema = {
        id: 'service_id',
        name: 'service_name',
        description: 'description',
        url: 'icon_url',
        create: 'created_at',
        update: 'updated_at'
    };

    @PrimaryColumn({
        type: "int",
        generated: true,
        unsigned: true,
        name: Service.schema.id
    })
    id: number;

    @Column({
        type: "varchar",
        length: 255,
        unique: true,
        name: Service.schema.name
    })
    name: string;

    @Column({
        type: "text",
        unique: true,
        name: Service.schema.description
    })
    description: string;

    @Column({
        type: "text",
        unique: true,
        name: Service.schema.url
    })
    url: string;

    @Column({
        type: "timestamp",
        precision: 6,
        default: () => "CURRENT_TIMESTAMP(6)",
        onUpdate: "CURRENT_TIMESTAMP(6)",
        name: Service.schema.create
    })
    create: Date;

    @Column({
        type: "timestamp",
        precision: 6,
        default: () => "CURRENT_TIMESTAMP(6)",
        onUpdate: "CURRENT_TIMESTAMP(6)",
        name: Service.schema.update
    })
    update: Date;

    @OneToMany(type => BuildingService, buildingService => buildingService.service)
    @JoinColumn({name: Service.schema.id})
    buildingServices: BuildingService[];

    static get repo(): ServiceRepository {
        return getCustomRepository(ServiceRepository);
    }
}

@EntityRepository(Service)
export class ServiceRepository extends Repository<Service> {
    async updateById(serviceId: any, serviceUpdate: Service) {
        let service = await this.findOne(serviceId);
        if (service) {
            service.name = serviceUpdate.name ? serviceUpdate.name : service.name;
            service.description = serviceUpdate.description ? serviceUpdate.description : service.description;
            service.url = serviceUpdate.url ? serviceUpdate.url : service.url;
            service.create = serviceUpdate.create ? serviceUpdate.create : service.create;
            service.update = serviceUpdate.update ? serviceUpdate.update : service.update;
            await this.save(service);
        }
        return service;
    }
}
