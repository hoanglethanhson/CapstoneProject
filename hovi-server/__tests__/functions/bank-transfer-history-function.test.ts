import server from '../../src/server-test';
import AuthFunction from "../../src/functions/auth-function";
import {DatabaseManager} from "../../src/models";

const supertest = require('supertest');

describe('Test function bankTransferHistory', () => {
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

   /* it('Test create bankTransferHistory with authentication', () => {
        return request
            .post('/bankTransferHistory')
            .set('Authorization', token)
            .send({bankData : [{senderUserId: 15, senderBank: 'test create', senderAccountNumber: 'test create bankTransferHistory',
                senderUserType: 1, receiverUserId: 1, receiverBank: 'abc', receiverAccountNumber: 'fff', receiverUserType:2,
                transferTime:'2019-11-13 15:22:26.007772', moneyAmount: 100, transferNote: 'aa', transferCode: 'aa'}]})
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });*/

    it('Test get all bankTransferHistory', () => {
        return request
            .get('/bankTransferHistory/')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test get bankTransferHistory by id', () => {
        return request
            .get('/bankTransferHistory/1')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });



    it('Test create bankTransferHistory without authentication', () => {
        return request
            .post('/bankTransferHistory')
            .set('Accept', 'application/json')
            .send({senderUserId: 15, senderBank: 'test create', senderAccountNumber: 'test create bankTransferHistory',
                senderUserType: 1, receiverUserId: 1, receiverBank: 'abc', receiverAccountNumber: 'fff', receiverUserType:2,
                transferTime:'2019-11-13 15:22:26.007772', moneyAmount: 100, transferNote: 'aa', transferCode: 'aa'})
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized')
            });
    });


    it('Test update bankTransferHistory with authentication', () => {
        return request
            .put('/bankTransferHistory/1')
            .send({senderUserId: 18, senderBank: 'test create', senderAccountNumber: 'test create bankTransferHistory',
                senderUserType: 1, receiverUserId: 1, receiverBank: 'abc', receiverAccountNumber: 'fff', receiverUserType:2,
                transferTime:'2019-11-13 15:22:26.007772', moneyAmount: 100, transferNote: 'aa', transferCode: 'aa'})
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test update bankTransferHistory without authentication', () => {
        return request
            .put('/bankTransferHistory/1')
            .send({senderUserId: 18, senderBank: 'test create', senderAccountNumber: 'test create bankTransferHistory',
                senderUserType: 1, receiverUserId: 1, receiverBank: 'abc', receiverAccountNumber: 'fff', receiverUserType:2,
                transferTime:'2019-11-13 15:22:26.007772', moneyAmount: 100, transferNote: 'aa', transferCode: 'aa'})
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized')
            });
    });

});
