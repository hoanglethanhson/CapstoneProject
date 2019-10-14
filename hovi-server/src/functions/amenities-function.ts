import {Request, Response, NextFunction, Handler} from "express";
import {validateByModel} from '../utils';
import {HTTP400Error} from '../utils/httpErrors';
import {Amenities} from "../models/amenities";

export default class AmenitiesFunction {
    static getAmenities: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const amenities = await Amenities.repo.find();
        if (amenities.length != 0) res.status(200).send(amenities);
        else next(new HTTP400Error('0 record.'));
    };

    static getAmenitiesOne: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const amenitiesId = req.params['amenitiesId'];
        const amenities = await Amenities.repo.findOne(amenitiesId);

        if (amenities) res.status(200).send(amenities);
        else next(new HTTP400Error('amenitiesId not found.'));
    };

    static createAmenities: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const error = await validateByModel(Amenities, body);

        if (error) next(error);
        else {
            const checkAmenities = await Amenities.repo.findOne({usableName: body['usableName']});

            if (checkAmenities) next(new HTTP400Error('amenities already exists'));
            else {
                const newAmenities = await Amenities.repo.save(body);
                const successResponse = await Amenities.repo.findOne({id: newAmenities.id});
                res.status(200).send(successResponse);
            }
        }
    };

    static updateAmenities: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const amenitiesId = req.params['amenitiesId'];
        const successResponse = await Amenities.repo.updateById(amenitiesId, body);

        if (successResponse) res.status(200).send(successResponse);
        else next(new HTTP400Error('amenitiesId not found'));
    };

    static deleteAmenities: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const amenitiesId = req.params['amenitiesId'];
        const successResponse = await Amenities.repo.delete(amenitiesId);

        if (successResponse.affected != 0) res.status(200).send("Delete amenities successfully !");
        else next(new HTTP400Error('amenities not found'));
    };
}
