import server from '../../src/server-test';
import AuthFunction from "../../src/functions/auth-function";
import {DatabaseManager} from "../../src/models";

const supertest = require('supertest');

describe('Test function roomImage', () => {
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

    it('Test get all roomImages', () => {
        return request
            .get('/roomImage/')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test get roomImage by id', () => {
        return request
            .get('/roomImage/100')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });


    /*it('Test create roomImage with authentication', () => {
        return request
            .post('/roomImage')
            .send({roomGroupId: 125, imageUrl: 'url'})
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });*/

    it('Test create roomImage without authentication', () => {
        return request
            .post('/roomImage')
            .send({roomGroupId: 125, imageUrl: 'url'})
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized')
            });
    });

});
