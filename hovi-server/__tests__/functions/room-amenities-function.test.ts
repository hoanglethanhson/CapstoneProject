import server from '../../src/server-test';
import AuthFunction from "../../src/functions/auth-function";
import {DatabaseManager} from "../../src/models";

const supertest = require('supertest');

describe('Test function roomAmenities', () => {
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

    it('Test get all roomAmenities', () => {
        return request
            .get('/roomAmenities/')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test get roomAmenities by roomGroup id', () => {
        return request
            .get('/roomAmenities/34')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    /*it('Test create roomAmenities with authentication', () => {
        return request
            .post('/roomAmenities')
            .send({iconId: 3, name: 'test create', description: 'test create roomAmenities'})
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });*/

    it('Test create roomAmenities without authentication', () => {
        return request
            .post('/roomAmenities')
            .send({iconId: 3, name: 'test create roomAmenities', description: 'test create roomAmenities'})
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized')
            });
    });


    /*it('Test update roomAmenities setting with authentication', () => {
        return request
            .put('/roomAmenities/1')
            .send({iconId: 3, name: 'test update roomAmenities', description: 'test update roomAmenities'})
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });*/

    it('Test update roomAmenities setting without authentication', () => {
        return request
            .put('/roomAmenities/1')
            .send({iconId: 3, name: 'test update roomAmenities', description: 'test update roomAmenities'})
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized')
            });
    });

});
