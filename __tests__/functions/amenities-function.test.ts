import server from '../../src/server-test';
import AuthFunction from "../../src/functions/auth-function";
import {DatabaseManager} from "../../src/models";

const supertest = require('supertest');

describe('Test function amenities', () => {
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

    it('Test get all amenities', () => {
        return request
            .get('/amenities/')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test get amenities by id', () => {
        return request
            .get('/amenities/100')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test create amenities with authentication', () => {
        let random = Math.random();
        return request
            .post('/amenities')
            .set('Authorization', token)
            .send({iconId: '3', usableName: 'test create 200' + random, unusableName: 'ub', description: 'test create amenities'})
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test create amenities without authentication', () => {
        let random = Math.random();
        return request
            .post('/amenities')
            .send({iconId: '3', usableName: 'test create' + random, unusableName: 'ub', description: 'test create amenities'})
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized')
            });
    });


    it('Test update amenities with authentication', () => {
        let random = Math.random();
        return request
            .put('/amenities/100')
            .send({iconId: '3', usableName: 'test create' + random, unusableName: 'ub', description: 'test create amenities'})
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test update amenities without authentication', () => {
        return request
            .put('/amenities/100')
            .send({iconId: '3',  usableName: 'test create', unusableName: 'ub', description: 'test create amenities'})
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized')
            });
    });

});
