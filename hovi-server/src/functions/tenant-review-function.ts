import {Request, Response, NextFunction, Handler} from "express";
import {validateByModel} from '../utils';
import {HTTP400Error} from '../utils/httpErrors';
import {TenantReview} from "../models/tenant-review";

export default class TenantReviewFunction {
    static getTenantReviews: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const tenantReviews = await TenantReview.repo.find();
        if (tenantReviews.length != 0) res.status(200).send(tenantReviews);
        else next(new HTTP400Error('0 record.'));
    };

    static getTenantReview: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const tenantReviewId = req.params['tenantReviewId'];
        const tenantReview = await TenantReview.repo.findOne(tenantReviewId);

        if (tenantReview) res.status(200).send(tenantReview);
        else next(new HTTP400Error('tenantReviewId not found.'));
    };

    static createTenantReview: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const error = await validateByModel(TenantReview, body);

        if (error) next(error);
        else {
            const newTenantReview = await TenantReview.repo.save(body);
            const successResponse = await TenantReview.repo.findOne({reviewId: newTenantReview.reviewId});
            res.status(200).send(successResponse);
        }
    };

    static updateTenantReview: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const tenantReviewId = req.params['tenantReviewId'];
        const successResponse = await TenantReview.repo.updateById(tenantReviewId, body);

        if (successResponse) res.status(200).send(successResponse);
        else next(new HTTP400Error('tenantReviewId not found'));
    };

    static deleteTenantReview: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const tenantReviewId = req.params['tenantReviewId'];
        const successResponse = await TenantReview.repo.delete(tenantReviewId);

        if (successResponse.affected != 0) res.status(200).send("Delete tenantReview successfully !");
        else next(new HTTP400Error('tenantReviewId not found'));
    };
}
