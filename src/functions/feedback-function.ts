import {Request, Response, NextFunction, Handler} from "express";
import {validateByModel} from '../utils';
import {HTTP400Error} from '../utils/httpErrors';
import {Feedback} from "../models/feedback";

export default class FeedbackFunction {
    static getFeedbacks: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const feedbacks = await Feedback.repo.find();

        if (feedbacks.length != 0) res.status(200).send(feedbacks);
        else next(new HTTP400Error('0 record.'));
    };

    static getFeedback: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const feedbackId = req.params['feedbackId'];
        const feedback = await Feedback.repo.findOne(feedbackId);

        if (feedback) res.status(200).send(feedback);
        else next(new HTTP400Error("feedbackId not found."));
    };

    static createFeedback: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const error = await validateByModel(Feedback, body);

        if (error) next(error);
        else {
            const newFeedback = await Feedback.repo.save(body);
            const successResponse = await Feedback.repo.findOne({feedbackId: newFeedback.feedbackId});
            res.status(200).send(successResponse);
        }
    };

    static updateFeedback: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const feedbackId = req.params['feedbackId'];
        const successResponse = await Feedback.repo.updateById(feedbackId, body);

        if (successResponse) res.status(200).send(successResponse);
        else next(new HTTP400Error('FeedbackId not found'));
    };

    static deleteFeedback: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const feedbackId = req.params['feedbackId'];
        const successResponse = await Feedback.repo.delete(feedbackId);

        if (successResponse.affected != 0) res.status(200).send("Delete feedback successfully !");
        else next(new HTTP400Error('Feedback not found'));
    };
}
