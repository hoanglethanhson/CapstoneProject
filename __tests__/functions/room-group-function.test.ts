import server from '../../src/server-test';
import AuthFunction from "../../src/functions/auth-function";
import {DatabaseManager} from "../../src/models";

const supertest = require('supertest');

describe('Test function roomGroup', () => {
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

    it('Test get all roomGroup', () => {
        return request
            .get('/roomGroup/')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test get roomGroup by building id', () => {
        return request
            .get('/roomGroup/100')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test get roomGroup detail by roomGroup id', () => {
        return request
            .get('/roomGroup/100')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test get transaction detail by transaction id with authentication but not user transaction', () => {
        return request
            .get('/transaction/100')
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('User is not in this transaction.');
            });
    });

    it('Test get transaction detail by transaction id without authentication', () => {
        return request
            .get('/transaction/100')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized');
            });
    });

    /*it('Test create roomGroup with authentication', () => {
        return request
            .post('/roomGroup')
            .send({buildingId: 17,
                area: 0,
                bathroom: 1,
                bedroom: 1,
                capacity: 1,
                depositPrice: "1000000",
                description: "abc",
                direction: "d co gi dm",
                gender: 2,
                rentPrice: "1500000"}
            )
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });*/

    it('Test create roomGroup without authentication', () => {
        return request
            .post('/roomGroup')
            .send({buildingId: 17,
                    area: 0,
                    bathroom: 1,
                    bedroom: 1,
                    capacity: 1,
                    depositPrice: "1000000",
                    description: "abc",
                    direction: "d co gi dm",
                    gender: 2,
                    rentPrice: "1500000"}
                )
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized')
            });
    });


    it('Test update roomGroup setting with authentication and group id not found', () => {
        return request
            .put('/roomGroup/1000')
            .send({buildingId: 9})
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(400);
            });
    });

    it('Test update roomGroup setting without authentication with group id not found', () => {
        return request
            .put('/roomGroup/140')
            .send({buildingId: 9})
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized')
            });
    });

});
