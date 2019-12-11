import server from '../../src/server-test';
import AuthFunction from "../../src/functions/auth-function";
import {DatabaseManager} from "../../src/models";

const supertest = require('supertest');

describe('Test function building', () => {
    let request = null;
    let token = null;

    beforeEach(async () => {
        await DatabaseManager.init();
        await DatabaseManager.clearData();
        await DatabaseManager.insertData();
        token = await AuthFunction.getIdToken('+84986352227');
        request = supertest(server);
    });

    afterAll(async (done) => {
        await DatabaseManager.close();
        await request.close();
        done();
    });

    it('Test create building with authentication not enough fields', () => {
        return request
            .post('/building')
            .send({buildingName: 'test building', typeId: 1})
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(400);
            });
    });

    it('Test create building without authentication not enough fields', () => {
        return request
            .post('/building')
            .send({buildingName: 'test building', typeId: 1})
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized');
            });
    });

    it('Test get all building', () => {
        return request
            .get('/building/')
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test get building by type id without authentication', () => {
        return request
            .get('/building/100')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized');
            });
    });

    it('Test get building by type id with authentication', () => {
        return request
            .get('/building/100')
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });


    /*it('Test update building setting with authentication', () => {
        return request
            .put('/building/113')
            .send({buildingName: 'update building', typeId: 1})
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });*/

    it('Test update building setting without authentication', () => {
        return request
            .put('/building/100')
            .send({buildingName: 'update building', typeId: 1})
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized');
            });
    });

});
