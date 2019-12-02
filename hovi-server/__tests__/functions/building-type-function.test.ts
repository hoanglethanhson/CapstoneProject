import createServer from './server';
import AuthFunction from "../../src/functions/auth-function";

const supertest = require('supertest');

describe('Test function building type', () => {
    let request = null;
    let server = null;
    let token;

    beforeEach(async (done) => {
        server = await createServer();
        server.listen(done);
        request = supertest.agent(server);
        token = await AuthFunction.getIdToken('+84986352227');
    });

    afterAll((done) => {
        request.close(done);
    });

    it('Test get all building type', () => {
        request
            .get('/buildingType')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test get all saved room of user not authentication', () => {
        request
            .get('/saved-rooms')
            .set('Accept', 'application/json')
            .expect(401)
            .expect('{"status":401,"message":"Unauthorized"}')
    });

    it('Test get all saved room of user', () => {
        request
            .get('/saved-rooms')
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .expect(200)
    });
});
