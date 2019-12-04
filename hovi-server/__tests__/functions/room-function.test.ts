import server from '../../src/server-test';
import AuthFunction from "../../src/functions/auth-function";
import {DatabaseManager} from "../../src/models";
import {ConstantValues} from "../../src/utils/constant-values";

const supertest = require('supertest');

describe('Test function room', () => {
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

    it('Test get all room', () => {
        return request
            .get('/room/')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test get room by id', () => {
        return request
            .get('/room/78')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test create room with authentication', () => {
        return request
            .post('/room')
            .send({roomGroupId: 34, roomName: 'test create room', roomStatus: ConstantValues.ROOM_AVAILABLE})
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test create room without authentication', () => {
        return request
            .post('/room')
            .send({roomGroupId: 34, roomName: 'test create room', roomStatus: ConstantValues.ROOM_AVAILABLE})
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized')
            });
    });


    it('Test update room setting with authentication', () => {
        return request
            .put('/room/305')
            .send({roomGroupId: 34, roomName: 'test update room', roomStatus: ConstantValues.ROOM_AVAILABLE})
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test update room setting without authentication', () => {
        return request
            .put('/room/305')
            .send({roomGroupId: 34, roomName: 'test update room', roomStatus: ConstantValues.ROOM_AVAILABLE})
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized')
            });
    });

});
