import {
  BaseEntity,
  Column,
  Entity,
  EntityRepository,
  getConnection,
  getCustomRepository,
  getManager,
  getRepository,
  JoinColumn,
  ManyToOne,
  PrimaryColumn,
  Repository,
} from 'typeorm';
import { Building } from './building';
import { Service } from './service';
import { HTTP400Error } from '../utils/httpErrors';

@Entity(BuildingService.tableName)
export class BuildingService extends BaseEntity {
  static readonly tableName = 'building_service';
  static readonly schema = {
    buildingId: 'building_id',
    serviceId: 'service_id',
    servicePrice: 'service_price',
    note: 'note',
    createAt: 'created_at',
    updateAt: 'updated_at',
  };


  @ManyToOne(type => Building, building => building.buildingServices)
  @JoinColumn({ name: BuildingService.schema.buildingId })
  building: Building;
  @PrimaryColumn({ name: BuildingService.schema.buildingId })
  buildingId: number;


  @ManyToOne(type => Service, service => service.buildingServices)
  @JoinColumn({ name: BuildingService.schema.serviceId })
  service: Service;
  @PrimaryColumn({ name: BuildingService.schema.serviceId })
  serviceId: number;

  @Column({
    type: 'double',
    name: BuildingService.schema.servicePrice,
  })
  servicePrice: number;

  @Column({
    type: 'text',
    unique: false,
    name: BuildingService.schema.note,
  })
  note: string;

  @Column({
    type: 'timestamp',
    precision: 6,
    default: () => 'CURRENT_TIMESTAMP(6)',
    onUpdate: 'CURRENT_TIMESTAMP(6)',
    name: BuildingService.schema.createAt,
  })
  createAt: Date;

  @Column({
    type: 'timestamp',
    precision: 6,
    default: () => 'CURRENT_TIMESTAMP(6)',
    onUpdate: 'CURRENT_TIMESTAMP(6)',
    name: BuildingService.schema.updateAt,
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
      buildingService.servicePrice = buildingServiceUpdate.servicePrice ? buildingServiceUpdate.servicePrice : buildingService.servicePrice;
      buildingService.note = buildingServiceUpdate.note ? buildingServiceUpdate.note : buildingService.note;
      await this.save(buildingService);
    }
    return buildingService;
  }

  async getServicesInBuilding(buildingId: any) {
    return await getRepository(Building)
      .createQueryBuilder('building')
      .innerJoinAndSelect('building.buildingServices', 'buildingService')
      .where('buildingService.buildingId = :bId', { bId: buildingId })
      .getOne();
  }

  async saveMultiBuildingServices(buildingId: number, services: any) {
    for (let i = 0; i < services.length; i++) {
      await this.saveBuildingService(buildingId, services[i].serviceId);
    }
  }

  async getOneRecord(buildingId: any, serviceId: any) {
    return await getRepository(BuildingService)
      .createQueryBuilder('buildingService')
      .where('building_id = :buildingId', { buildingId: buildingId })
      .andWhere('service_id = :serviceId', { serviceId: serviceId })
      .getOne();
  }

  async deleteOneRecord(buildingId: any, serviceId: any) {
    return await getConnection()
      .createQueryBuilder()
      .delete()
      .from(BuildingService)
      .where('buildingId = :buildingId', { buildingId: buildingId })
      .andWhere('serviceId = :serviceId', { serviceId: serviceId })
      .execute();
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
    return await getManager()
      .createQueryBuilder(BuildingService, 'building_service')
      .select(['service.service_id', 'service.service_name', 'building_service.service_price'])
      .innerJoin(Building, 'building', 'building.building_id = building_service.building_id')
      .innerJoin(Service, 'service', 'service.service_id = building_service.service_id')
      .where('building_service.building_id = :building_id', { building_id: buildingId })
      .getRawMany();
  }

}
