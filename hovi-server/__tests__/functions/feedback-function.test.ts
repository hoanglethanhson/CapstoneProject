import server from '../../src/server-test';
import AuthFunction from "../../src/functions/auth-function";
import {DatabaseManager} from "../../src/models";

const supertest = require('supertest');

describe('Test function feedback', () => {
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

    it('Test create feedback with authentication', () => {
        return request
            .post('/feedback')
            .send({userId: 1, email: 'test create', content: 'test create feedback'})
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test get all feedback', () => {
        return request
            .get('/feedback/')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });


    it('Test get feedback by id', () => {
        return request
            .get('/feedback/1')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });


    it('Test create feedback without authentication', () => {
        return request
            .post('/feedback')
            .send({userId: 1, email: 'test create', content: 'test create feedback'})
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });


    it('Test update feedback setting with authentication', () => {
        return request
            .put('/feedback/1')
            .send({userId: 1, email: 'test update', content: 'test create update'})
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test update feedback setting without authentication', () => {
        return request
            .put('/feedback/1')
            .send({userId: 1, email: 'test update', content: 'test create feedback'})
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

});
