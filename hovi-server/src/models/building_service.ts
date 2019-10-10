import {
    BaseEntity,
    Column,
    Entity,
    EntityRepository, getCustomRepository,
    Repository,
    PrimaryColumn, Index, ManyToOne, JoinColumn, createQueryBuilder, getRepository, getConnection
} from 'typeorm';
import {Building} from "./building";
import {Service} from "./service";

@Entity(BuildingService.tableName)
export class BuildingService extends BaseEntity {
    static readonly tableName = 'building_service';
    static readonly schema = {
        buildingId: 'building_id',
        serviceId: 'service_id',
        servicePrice: 'service_price',
        createAt: 'created_at',
        updateAt: 'updated_at'
    };


    @ManyToOne(type => Building, building => building.buildingServices)
    @JoinColumn({name: BuildingService.schema.buildingId})
    building: Building;
    @PrimaryColumn({name: BuildingService.schema.buildingId})
    buildingId: number;


    @ManyToOne(type => Service, service => service.buildingServices)
    @JoinColumn({name: BuildingService.schema.serviceId})
    service: Service;
    @PrimaryColumn({name: BuildingService.schema.serviceId})
    serviceId: number;

    @Column({
        type: "double",
        name: BuildingService.schema.servicePrice
    })
    servicePrice: number;

    @Column({
        type: "timestamp",
        precision: 6,
        default: () => "CURRENT_TIMESTAMP(6)",
        onUpdate: "CURRENT_TIMESTAMP(6)",
        name: BuildingService.schema.createAt
    })
    createAt: Date;

    @Column({
        type: "timestamp",
        precision: 6,
        default: () => "CURRENT_TIMESTAMP(6)",
        onUpdate: "CURRENT_TIMESTAMP(6)",
        name: BuildingService.schema.updateAt
    })
    updateAt: Date;


    static get repo(): BuildingServiceRepository {
        return getCustomRepository(BuildingServiceRepository);
    }
}

@EntityRepository(BuildingService)
export class BuildingServiceRepository extends Repository<BuildingService> {
    async updateById(buildingServiceId: any, buildingServiceUpdate: BuildingService) {
        let buildingService = await this.findOne(buildingServiceId);
        if (buildingService) {
            buildingService.buildingId = buildingServiceUpdate.buildingId ? buildingServiceUpdate.buildingId : buildingService.buildingId;
            buildingService.serviceId = buildingServiceUpdate.serviceId ? buildingServiceUpdate.serviceId : buildingService.serviceId;
            buildingService.servicePrice = buildingServiceUpdate.servicePrice ? buildingServiceUpdate.servicePrice : buildingService.servicePrice;
            buildingService.createAt = buildingServiceUpdate.createAt ? buildingServiceUpdate.createAt : buildingService.createAt;
            buildingService.updateAt = buildingServiceUpdate.updateAt ? buildingServiceUpdate.updateAt : buildingService.updateAt;
            await this.save(buildingService);
        }
        return buildingService;
    }

    async getServicesInBuilding(buildingId: any) {
        const services = await getRepository(Building)
            .createQueryBuilder("building")
            .innerJoinAndSelect("building.buildingServices", "buildingService")
            .where("buildingService.buildingId = :bId", {bId: buildingId})
            .getMany();
        return services;
    }

    async getOneRecord(buildingId: any, serviceId: any) {
        const record = await getRepository(BuildingService)
            .createQueryBuilder("buildingService")
            .where("buildingId = :buildingId", {buildingId: buildingId})
            .andWhere("serviceId = :serviceId", {serviceId: serviceId})
            .getOne();
        return record;
    }

    async deleteOneRecord(buildingId: any, serviceId: any) {
        const record = await getConnection()
            .createQueryBuilder()
            .delete()
            .from(BuildingService)
            .where("buildingId = :buildingId", {buildingId: buildingId})
            .andWhere("serviceId = :serviceId", {serviceId: serviceId})
            .execute();
        return record;
    }
}
