import server from '../../src/server-test';
import AuthFunction from "../../src/functions/auth-function";
import {DatabaseManager} from "../../src/models";

const supertest = require('supertest');

describe('Test function reportedRoom', () => {
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

    it('Test get all reportedRoom', () => {
        return request
            .get('/reportedRoom/')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test get reportedRoom by id', () => {
        return request
            .get('/reportedRoom/1')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test create reportedRoom with authentication', () => {
        return request
            .post('/reportedRoom')
            .send({userId: 1, roomGroupId: 34, reportContent: 'test create reportedRoom'})
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test create reportedRoom without authentication', () => {
        return request
            .post('/reportedRoom')
            .send({userId: 1, roomGroupId: 34, reportContent: 'test create reportedRoom'})
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized')
            });
    });


    it('Test update reportedRoom setting with authentication', () => {
        return request
            .put('/reportedRoom/1')
            .send({userId: 1, roomGroupId: 34, reportContent: 'test update reportedRoom'})
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test update reportedRoom setting without authentication', () => {
        return request
            .put('/reportedRoom/1')
            .send({userId: 1, roomGroupId: 34, reportContent: 'test update reportedRoom'})
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized')
            });
    });

});
