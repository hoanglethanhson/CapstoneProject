import createServer from './server';
import AuthFunction from "../../src/functions/auth-function";

const request = require('supertest');

describe('Test function building type', () => {
    let api;
    let token;

    beforeEach(async () => {
        api = await createServer();
        token = await AuthFunction.getIdToken('+84986352227');
    });

    it('Test get all building type', () => {
        return request(api)
            .get('/buildingType')
            .then(response => {
                expect(response.status).toBe(200);
            })
    });

    it('Test get all saved room of user not authentication', (done) => {
        request(api)
            .get('/saved-rooms')
            .set('Accept', 'application/json')
            .expect(401)
            .expect('{"status":401,"message":"Unauthorized"}')
            .end((err) => {
                if (err) return done(err);
                done();
            });
    });

    it('Test get all saved room of user', (done) => {
        request(api)
            .get('/saved-rooms')
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .expect(200, done)
    });
});
