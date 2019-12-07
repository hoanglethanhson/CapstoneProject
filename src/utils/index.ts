import {Router, Handler} from 'express';
import {validate} from 'class-validator';
import multer, {memoryStorage} from 'multer';
import Authentication from '../middleware/authentication';
import {HTTP400Error} from './httpErrors';

const request = require('request');

type Wrapper = ((router: Router) => void);

export const applyMiddleware = (
    middlewareWrappers: Wrapper[],
    router: Router,
) => {
    for (const wrapper of middlewareWrappers) {
        wrapper(router);
    }
};

type Route = {
    path: string;
    method: string;
    authentication?: boolean;
    uploadOptions?: UploadOptions;
    handler: Handler;
}

type UploadOptions = {
    type: string;
    fileSize: number;
    isMultiple: boolean;
    maxQuantity?: number;
}

export const applyRoutes = (routes: Route[], router: Router) => {
    for (const route of routes) {
        let imageMiddleware = [];
        const {method, path, handler, authentication = false, uploadOptions} = route;

        if (uploadOptions) {
            const {type, fileSize, isMultiple, maxQuantity} = uploadOptions;
            const upload = multer({storage: memoryStorage(), limits: {fileSize}});
            imageMiddleware = isMultiple ? upload.array(type, maxQuantity) : upload.single(type);
        }

        (router as any)[method](path, authentication ? Authentication : [], imageMiddleware, handler);
    }
};

export const unCamelCase = (str) => {
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

export const getCurrentDate = () => {
    let today = new Date();
    let dd = today.getDate();
    let mm = today.getMonth() + 1; //January is 0!
    let yyyy = today.getFullYear();
    return `${dd < 10 ? `0${dd}` : dd}-${mm < 10 ? `0${mm}` : mm}-${yyyy}`;
};

export const isObject = (value) => {
    return value && typeof value === 'object' && value.constructor === Object;
};

export const buildingTitle = (buildingName: string, province: string, district: string, ward: string) => {
    return `${buildingName} - ${JSON.parse(ward)[0]}, ${JSON.parse(district)[0]}, ${JSON.parse(province)[0]}`;
};

type RequestParams = {
    method: string,
    path: string,
    body?: object
}
export const FirebaseAuthRequest = (requestPrams: RequestParams, callback) => {
    const base_url = 'https://identitytoolkit.googleapis.com/v1/accounts';
    const buildUrl = `${base_url}:${requestPrams.path}?key=${process.env.FIREBASE_API_KEY}`;
    request[requestPrams.method](buildUrl, {
        json: requestPrams.body
    }, callback);
};

export const SearchServiceRequest = (path: string, method: string = 'GET', idToken: string = '') =>
    new Promise((resolve, reject) => {
        const options = {
            url: `${process.env.SEARCH_SERVICE_PATH || 'http://localhost:8081'}${path}`,
            method,
            headers: {
                'Content-Type': 'application/json',
                'Authorization': idToken
            }
        };

        request(options, (error, response, body) => {
            if (error) reject(error);
            else resolve(body);
        });
    });
