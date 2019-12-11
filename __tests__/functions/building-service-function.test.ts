import server from '../../src/server-test';
import AuthFunction from "../../src/functions/auth-function";
import {DatabaseManager} from "../../src/models";

const supertest = require('supertest');

describe('Test function buildingService', () => {
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

    it('Test get all buildingService', () => {
        return request
            .get('/buildingService/')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test get buildingService by building id', () => {
        return request
            .get('/buildingService/100')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    /*it('Test create buildingService with authentication', () => {
        return request
            .post('/buildingService')
            .send({iconId: 3, name: 'test create', description: 'test create buildingService'})
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });*/

    it('Test create buildingService without authentication', () => {
        return request
            .post('/buildingService')
            .send({iconId: '3', name: 'test create buildingService', description: 'test create buildingService'})
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized')
            });
    });


    /*it('Test update buildingService setting with authentication', () => {
        return request
            .put('/buildingService/1')
            .send({iconId: 3, name: 'test update buildingService', description: 'test update buildingService'})
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });*/

    it('Test update buildingService setting without authentication', () => {
        return request
            .put('/buildingService/100/100')
            .send({iconId: '3', name: 'test update buildingService', description: 'test update buildingService'})
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized')
            });
    });

});
