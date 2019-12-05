import server from '../../src/server-test';
import AuthFunction from "../../src/functions/auth-function";
import {DatabaseManager} from "../../src/models";

const supertest = require('supertest');

describe('Test function service', () => {
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

    it('Test get all service', () => {
        return request
            .get('/service/')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test get service by id', () => {
        return request
            .get('/service/1')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test create service with authentication', () => {
        let random = Math.random();
        return request
            .post('/service')
            .set('Authorization', token)
            .send({iconId: '3', name: 'test create ' + random, description: 'test create service'})
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test create service without authentication', () => {
        return request
            .post('/service')
            .send({iconId: '3', name: 'test create service', description: 'test create service'})
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized')
            });
    });


    it('Test update service with authentication', () => {
        return request
            .put('/service/1')
            .send({iconId: '3', name: 'test update service', description: 'test update service'})
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test update service without authentication', () => {
        let random = Math.random();
        return request
            .put('/service/1')
            .send({iconId: '3', name: 'test update service' + random, description: 'test update service'})
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized')
            });
    });

});
