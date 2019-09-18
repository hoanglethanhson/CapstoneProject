import {Router, Handler} from "express";
import {validate} from 'class-validator';
import config from '../../config';
import Authentication from '../middleware/authentication';
import {HTTP400Error} from './httpErrors';

type Wrapper = ((router: Router) => void);

export const applyMiddleware = (
    middlewareWrappers: Wrapper[],
    router: Router
) => {
    for (const wrapper of middlewareWrappers) {
        wrapper(router);
    }
};

type Route = {
    path: string;
    method: string;
    authentication: boolean,
    handler: Handler;
};

export const applyRoutes = (routes: Route[], router: Router) => {
    for (const route of routes) {
        const {method, path, handler, authentication} = route;
        (router as any)[method](config.API_PATH + path, authentication ? [Authentication, handler] : handler);
    }
};

const unCamelCase = (str) => {
    return str
    // insert a space before all caps
        .replace(/([A-Z])/g, ' $1')
        // uppercase the first character
        .replace(/^./, str => str.toUpperCase());
};

export const validateByModel = async (modelClass: any, body: any) => {
    const validationResult = await validate(modelClass.repo.create(body));
    if (validationResult.length > 0) {
        const detailErrors = validationResult.reduce(
            (res, item) => {
                let errorMessage = Object.keys(item.constraints).map((key) => {
                    return item.constraints[key];
                }).join(', ');
                errorMessage = errorMessage.replace(item.property, unCamelCase(item.property));
                return {...res, [item.property]: `${errorMessage}.`};
            },
            {},
        );
        return new HTTP400Error(detailErrors);
    }
};
