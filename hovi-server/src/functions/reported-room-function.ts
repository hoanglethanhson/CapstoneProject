import {Request, Response, NextFunction, Handler} from "express";
import {validateByModel} from '../utils';
import {HTTP400Error} from '../utils/httpErrors';
import {ReportedRoom} from "../models/reported-room";
import {User} from "../models/user";

export default class ReportedRoomFunction {
    static getReportedRooms: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const reportedRooms = await ReportedRoom.repo.find();
        let result = [];
        for (const reportedRoom of reportedRooms) {
            const user = await User.repo.findOne(reportedRoom);
            const element = {
                reportedRoom,
                user
            }
            result.push(element);
        }

        if (result.length != 0) res.status(200).send(result);
        else next(new HTTP400Error('0 record.'));
    };

    static getReportedRoom: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const reportedRoomId = req.params['reportId'];
        const reportedRoom = await ReportedRoom.repo.findOne(reportedRoomId);
        const user = await User.repo.findOne(reportedRoom)
        const result = {
            reportedRoom,
            user
        }

        if (result) res.status(200).send(result);
        else next(new HTTP400Error('reportedRoomId not found.'));
    };

    static createReportedRoom: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const error = await validateByModel(ReportedRoom, body);

        if (error) next(error);
        else {
            const newReportedRoom = await ReportedRoom.repo.save(body);
            const successResponse = await ReportedRoom.repo.findOne(newReportedRoom.reportId);
            res.status(200).send(successResponse);
        }
    };

    static updateReportedRoom: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const body = req.body || {};
        const reportedRoomId = req.params['reportedRoomId'];
        const successResponse = await ReportedRoom.repo.updateById(reportedRoomId, body);

        if (successResponse) res.status(200).send(successResponse);
        else next(new HTTP400Error('ReportedRoomId not found'));
    };

    static deleteReportedRoom: Handler = async (req: Request, res: Response, next: NextFunction) => {
        const reportedRoomId = req.params['reportedRoomId'];
        const successResponse = await ReportedRoom.repo.delete(reportedRoomId);

        if (successResponse.affected != 0) res.status(200).send("Delete reportedRoom successfully !");
        else next(new HTTP400Error('ReportedRoom not found'));
    };
}
