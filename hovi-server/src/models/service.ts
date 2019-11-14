import {
  BaseEntity,
  Unique,
  Column,
  Entity,
  EntityRepository, getCustomRepository,
  Repository,
  PrimaryColumn, OneToMany, JoinColumn,
} from 'typeorm';
import { BuildingService } from './building-service';
import { Length } from 'class-validator';

@Entity(Service.tableName)
@Unique(['name'])
export class Service extends BaseEntity {
  static readonly tableName = 'service';
  static readonly schema = {
    id: 'service_id',
    iconId: 'icon_id',
    name: 'service_name',
    description: 'description',
    create: 'created_at',
    update: 'updated_at',
  };

  @PrimaryColumn({
    type: 'int',
    generated: true,
    unsigned: true,
    name: Service.schema.id,
  })
  id: number;

  @Column({
    type: 'varchar',
    length: 50,
    name: Service.schema.iconId,
  })
  @Length(0, 50)
  iconId: string;

  @Column({
    type: 'varchar',
    length: 255,
    unique: true,
    name: Service.schema.name,
  })
  name: string;

  @Column({
    type: 'text',
    unique: false,
    name: Service.schema.description,
  })
  description: string;


  @Column({
    type: 'timestamp',
    name: Service.schema.create,
  })
  create: Date;

  @Column({
    type: 'timestamp',
    name: Service.schema.update,
  })
  update: Date;

  @OneToMany(type => BuildingService, buildingService => buildingService.service)
  @JoinColumn({ name: Service.schema.id })
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
      service.iconId = serviceUpdate.iconId ? serviceUpdate.iconId : service.iconId;
      service.description = serviceUpdate.description ? serviceUpdate.description : service.description;
      await this.save(service);
    }
    return service;
  }
}
