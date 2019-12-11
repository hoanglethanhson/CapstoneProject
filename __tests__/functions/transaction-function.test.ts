import server from '../../src/server-test';
import AuthFunction from "../../src/functions/auth-function";
import {DatabaseManager} from "../../src/models";

const supertest = require('supertest');

describe('Test function transaction', () => {
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

    it('Test get all transactions', () => {
        return request
            .get('/transaction')
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test get transaction money transfer content with authentication but not user transaction', () => {
        return request
            .get('/transactionGen/100')
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(303);
            });
    });

    it('Test get transaction money transfer content without authentication', () => {
        return request
            .get('/transactionGen/100')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized')
            });
    });

   /* it('Test create transaction with authentication', () => {
        //supertest.setTimeout(30000);
        jest.setTimeout(30000);
        return request
            .post('/transaction/100')
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });*/

    it('Test create transaction without authentication', () => {
        return request
            .post('/transaction/100')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized')
            });
    });

    it('Test get transaction money transfer content not authentication', () => {
        return request
            .get('/transactionGen/100')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized')
            });
    });

    it('Test get all transactions without authentication', () => {
        return request
            .get('/transaction')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized')
            });
    });
});
