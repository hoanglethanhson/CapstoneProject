import { RoomGroup } from '../models/room-group';
import { Building } from '../models/building';
import { Client } from 'elasticsearch';
import config from '../../config';

/**
 * Create connecting to elasticSearch
 */
const client = new Client({
  host: config.ES_ENDPOINT,
});

/**
 * Create rooms index
 */
const ROOMS_INDEX = 'rooms';
/**
 * Create rooms type for index
 */
const ROOMS_TYPE = 'doc';
/**
 * Create structure for rooms
 */
const STRUCTURE = {
  buildingName: { type: 'text' },
  buildingTypeId: { type: 'integer' },
  roomGroupId: { type: 'integer' },
  location: {
    type: 'nested',
    properties: {
      province: {
        type: 'keyword',
      },
      district: {
        type: 'keyword',
      },
      ward: {
        type: 'keyword',
      },
      detailAddress: {
        type: 'text',
      },
      addressDescription: {
        type: 'text',
      },
      coordinates: {
        type: 'geo_point',
      },
    },
  },
  gender: { type: 'byte' },
  rentPrice: { type: 'integer' },
  depositPrice: { type: 'integer' },
  area: { type: 'integer' },
  bedRoomQuantity: { type: 'integer' },
  bathRoomQuantity: { type: 'integer' },
  direction: { type: 'keyword' },
  capacity: { type: 'integer' },
  viewAmount: { type: 'integer' },
  isAvailable: { type: 'byte' },
  isSponsored: { type: 'byte' },
  amenities: {
    type: 'nested',
    properties: {
      id: {
        type: 'integer',
      },
      name: {
        type: 'text',
      },
    },
  },
  roomImages: {
    type: 'text',
  },
  updated_at: { type: 'date', format: 'yyyy-MM-dd' },
  num_views: { type: 'long', null_value: 0 },
};

export default class EsFunction {
  static createRoomES = async (roomGroup: RoomGroup) => {
    const building = await Building.repo.findOne(roomGroup.buildingId);
    const location = {
      province: building.province,
      district: building.district,
      ward: building.ward,
      detailAddress: building.detailedAddress,
      addressDescription: building.detailedAddress
    };

    client.index({
      index: ROOMS_INDEX,
      type: ROOMS_TYPE,
      id: roomGroup.id,
      body: location,
    });
  };
}
