import createServer from '../../src/server-test';
import AuthFunction from "../../src/functions/auth-function";

const supertest = require('supertest');

describe('Test function building type', () => {
    let request = null;
    let server = null;
    let token;

    beforeEach(async (done) => {
        server = await createServer();
        await server.listen(done);
        request = await supertest.agent(server);
        token = await AuthFunction.getIdToken('+84986352227');
    });

    afterAll(async (done) => {
        request.close(done);
    });

    it('Test get all building type', async () => {
        request
            .get('/buildingType')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test get all saved room of user not authentication', async () => {
        request
            .get('/saved-rooms')
            .set('Accept', 'application/json')
            .expect(401)
            .expect('{"status":401,"message":"Unauthorized"}')
    });

    it('Test get all saved room of user', async () => {
        request
            .get('/saved-rooms')
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .expect(200)
    });
});
