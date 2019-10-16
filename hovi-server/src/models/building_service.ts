import {
    BaseEntity,
    Column,
    Entity,
    EntityRepository, getCustomRepository,
    Repository,
    PrimaryColumn, Index, ManyToOne, JoinColumn, createQueryBuilder, getRepository, getConnection, getManager
} from 'typeorm';
import {Building} from "./building";
import {Service} from "./service";
import {HTTP400Error} from "../utils/httpErrors";

@Entity(BuildingService.tableName)
export class BuildingService extends BaseEntity {
    static readonly tableName = 'building_service';
    static readonly schema = {
        buildingId: 'building_id',
        serviceId: 'service_id',
        servicePrice: 'service_price',
        note: 'note',
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
        type: "text",
        unique: false,
        name: BuildingService.schema.note
    })
    note: string;

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
    async updateById(buildingId: any, serviceId: any, buildingServiceUpdate: BuildingService) {
        let buildingService = await this.getOneRecord(buildingId, serviceId);
        if (buildingService) {
            buildingService.buildingId = buildingServiceUpdate.buildingId ? buildingServiceUpdate.buildingId : buildingService.buildingId;
            buildingService.serviceId = buildingServiceUpdate.serviceId ? buildingServiceUpdate.serviceId : buildingService.serviceId;
            buildingService.note = buildingServiceUpdate.note ? buildingServiceUpdate.note : buildingService.note;
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

    async saveBuildingService(buildingId: number, serviceId: any) {
        const checkBuildingService = await BuildingService.repo.getOneRecord(buildingId, serviceId);
        let record;
        if (checkBuildingService) {
            record = new HTTP400Error('This building-service pair already exists');
        }
        record = await getConnection()
            .createQueryBuilder()
            .insert()
            .into(BuildingService)
            .values({ buildingId: buildingId, serviceId: serviceId })
            .execute();

        return record;
    }

    async getServiceDetailBuilding(buildingId: any) {
        const services = await getManager()
            .createQueryBuilder(BuildingService, "building_service")
            .select(["service.service_name", "building_service.service_price"])
            .innerJoin(Building, "building", "building.building_id = building_service.building_id")
            .innerJoin(Service, "service", "service.service_id = building_service.service_id")
            .where("building_service.building_id = :building_id", {building_id: buildingId})
            .getRawMany();
        return services;
    }

    async saveMultiBuildingServices(buildingId: number, services: any) {
        for (let i = 0; i < services.length; i++) {
            await this.saveBuildingService(buildingId, services[i].serviceId);
        }
    }
}
