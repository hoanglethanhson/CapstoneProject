import server from '../../src/server-test';
import AuthFunction from "../../src/functions/auth-function";
import {DatabaseManager} from "../../src/models";

const supertest = require('supertest');

describe('Test function adminBankAccount', () => {
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

    it('Test get all adminBankAccount', () => {
        return request
            .get('/adminBankAccount/')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test get adminBankAccount by id', () => {
        return request
            .get('/adminBankAccount/100')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test create adminBankAccount with authentication', () => {
        return request
            .post('/adminBankAccount')
            .set('Authorization', token)
            .send({bank: 'bank', accountNumber: '1234', holderName: 'holder'})
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test create adminBankAccount without authentication', () => {
        return request
            .post('/adminBankAccount')
            .send({bank: 'bank', accountNumber: '1234', holderName: 'holder'})
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized')
            });
    });


    it('Test update adminBankAccount with authentication', () => {
        return request
            .put('/adminBankAccount/100')
            .send({bank: 'bank', accountNumber: '1234', holderName: 'holder update'})
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test update adminBankAccount without authentication', () => {
        return request
            .put('/adminBankAccount/100')
            .send({bank: 'bank', accountNumber: '1234', holderName: 'holder update'})
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized')
            });
    });

});
