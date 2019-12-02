import {Request, Response, NextFunction, Handler} from "express";
import {validateByModel} from '../utils';
import {HTTP400Error} from '../utils/httpErrors';
import {HostReview} from "../models/host-review";

export default class HostReviewFunction {
    static getHostReviews: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const hostReviews = await HostReview.repo.find();

        if (hostReviews.length != 0) res.status(200).send(hostReviews);
        else next(new HTTP400Error('0 record.'));
    };

    static getHostReview: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const hostReviewId = req.params['reviewId'];
        const hostReview = await HostReview.repo.findOne(hostReviewId);

        if (hostReview) res.status(200).send(hostReview);
        else next(new HTTP400Error('hostReviewId not found.'));
    };

    static createHostReview: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const error = await validateByModel(HostReview, body);

        if (error) next(error);
        else {
            const newHostReview = await HostReview.repo.save(body);
            const successResponse = await HostReview.repo.findOne(newHostReview.accountId);
            res.status(200).send(successResponse);
        }
    };

    static updateHostReview: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const hostReviewId = req.params['hostReviewId'];
        const successResponse = await HostReview.repo.updateById(hostReviewId, body);

        if (successResponse) res.status(200).send(successResponse);
        else next(new HTTP400Error('HostReviewId not found'));
    };

    static deleteHostReview: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const hostReviewId = req.params['hostReviewId'];
        const successResponse = await HostReview.repo.delete(hostReviewId);

        if (successResponse.affected != 0) res.status(200).send("Delete hostReview successfully !");
        else next(new HTTP400Error('HostReview not found'));
    };
}