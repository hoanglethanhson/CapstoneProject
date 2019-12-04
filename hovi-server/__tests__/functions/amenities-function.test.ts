import server from '../../src/server-test';
import AuthFunction from "../../src/functions/auth-function";
import {DatabaseManager} from "../../src/models";

const supertest = require('supertest');

describe('Test function amenities', () => {
    let request = null;
    let token = null;

    beforeEach(async () => {
        await DatabaseManager.init();
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
            .get('/amenities/1')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test create amenities with authentication', () => {
        return request
            .post('/amenities')
            .set('Authorization', token)
            .send({iconId: '3', usableName: 'test create 200', unusableName: 'ub', description: 'test create amenities'})
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test create amenities without authentication', () => {
        return request
            .post('/amenities')
            .send({iconId: 3, usableName: 'test create', unusableName: 'ub', description: 'test create amenities'})
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized')
            });
    });


    it('Test update amenities with authentication', () => {
        return request
            .put('/amenities/1')
            .send({iconId: '3', usableName: 'test create', unusableName: 'ub', description: 'test create amenities'})
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test update amenities without authentication', () => {
        return request
            .put('/amenities/1')
            .send({iconId: '3',  usableName: 'test create', unusableName: 'ub', description: 'test create amenities'})
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized')
            });
    });

});
