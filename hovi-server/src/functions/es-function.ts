import { Handler, NextFunction, Request, Response } from 'express';
import { HTTP404Error, HTTP400Error } from '../utils/httpErrors';
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
  bedroomQuantity: { type: 'integer' },
  bathroomQuantity: { type: 'integer' },
  direction: { type: 'keyword' },
  capacity: { type: 'integer' },
  viewAmount: { type: 'integer', null_value: 0 },
  isAvailable: { type: 'byte', null_value: 1 },
  isSponsored: { type: 'byte', null_value: 0 },
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
  updatedAt: { type: 'date', format: 'yyyy-MM-dd' },
};

export default class EsFunction {

  /**
   * Initialization index (remove already exists index if have)
   * @param req
   * @param res
   * @param next
   */
  static esInit: Handler = async (req: Request, res: Response, next: NextFunction) => {
    const alreadyExists = await client.indices.exists({ index: [ROOMS_INDEX] });
    if (alreadyExists) await client.indices.delete({ index: ROOMS_INDEX });

    const locationsIndex = {
      index: ROOMS_INDEX,
      body: {
        mappings: {
          [ROOMS_TYPE]: {
            properties: STRUCTURE,
          },
        },
      },
    };

    console.log(locationsIndex);

    const check = await client.indices.create(locationsIndex); // Initialization index
    console.log(check);
    const response = await client.indices.exists({ index: [ROOMS_INDEX] }); // Check index is exists
    res.status(200).send(response);
  };

  /**
   *
   * @param req
   * @param res
   * @param next
   */
  static createRoomES: Handler = async (req: Request, res: Response, next: NextFunction) => {
    const buildingId = req.params['buildingId'];

    if (isNaN(Number(buildingId))) next(new HTTP404Error('Building id is invalid.'));
    else {
      const building = await Building.repo.getBuildingInformationById(Number(buildingId));
      if (building) {
        const { typeId, buildingName, location, roomGroups, province, district, ward, addressDescription, detailedAddress } = building;
        const dataLocation = {
          detailAddress: detailedAddress,
          addressDescription: addressDescription,
          province: JSON.parse(province)[1],
          district: JSON.parse(district)[1],
          ward: JSON.parse(ward)[1],
          coordinates: {
            lat: String(location).split(',')[0],
            lon: String(location).split(',')[1],
          },
        };

        const posts = roomGroups.map(roomGroup => {
          const { id, gender, rentPrice, depositPrice, area, bedroomQuantity, bathroomQuantity, direction, capacity, roomAmenities, roomImages } = roomGroup;
          const dataRoomImages = roomImages.map(data => data.imageUrl);
          const amenities = roomAmenities.map(data => {
            const { id, unusableName, usableName } = data.amenities;
            return { id, name: unusableName ? unusableName : usableName };
          });
          return {
            buildingTypeId: typeId,
            roomGroupId: id,
            roomImages: dataRoomImages,
            location: dataLocation,
            buildingName,
            gender,
            rentPrice,
            depositPrice,
            area,
            bedroomQuantity,
            bathroomQuantity,
            direction,
            capacity,
            amenities,
            updatedAt: '2019-09-26',
          };
        });

        // format documents (settings id of documents)
        const documents = posts.reduce(
          (res, { roomGroupId, ...doc }) => res.concat([
            { update: { _id: roomGroupId } },
            {
              doc, doc_as_upsert: true,
            },
          ]),
          [],
        );

        console.log(documents);
        // using bulk (elasticSearch) to create multiple locations at once
        client.bulk({
          index: ROOMS_INDEX,
          type: ROOMS_TYPE,
          body: documents,
        }).then(response => {
          console.debug(response);
          res.status(200).send(response);
        }).catch(error => {
          console.log(error.message);
          next(new HTTP404Error(error.message));
        });
      } else next(new HTTP404Error('Building id not found.'));
    }
  };
}
