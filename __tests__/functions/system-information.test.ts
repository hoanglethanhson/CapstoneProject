import server from '../../src/server-test';
import AuthFunction from "../../src/functions/auth-function";
import {DatabaseManager} from "../../src/models";

const supertest = require('supertest');

describe('Test function systemInformation', () => {
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

    it('Test get all systemInformation', () => {
        return request
            .get('/systemInformation/')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test get systemInformation by id', () => {
        return request
            .get('/systemInformation/100')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test create systemInformation setting with authentication', () => {
        return request
            .post('/systemInformation')
            .send({title: 'test create', content: 'test create'})
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test create systemInformation without authentication', () => {
        return request
            .post('/systemInformation')
            .send({title: 'test create', content: 'test create'})
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized')
            });
    });


    it('Test update systemInformation with authentication', () => {
        return request
            .put('/systemInformation/100')
            .send({title: 'test update', content: 'test update'})
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test update systemInformation setting without authentication', () => {
        return request
            .put('/systemInformation/100')
            .send({title: 'test update', content: 'test update'})
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized')
            });
    });

});
