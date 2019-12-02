import createServer from '../../src/server-test';
import AuthFunction from "../../src/functions/auth-function";

const supertest = require('supertest');

describe('Test function building type', () => {
    let request = null;
    let server = null;
    let token = null;

    beforeEach(async (done) => {
        server = await createServer();
        token = await AuthFunction.getIdToken('+84986352227');
        request = await supertest.agent(server.listen(done));
    });

    afterAll(async () => {
        await request.close();
    });

    it('Test get all building type', () => {
        return request
            .get('/buildingType')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test get all saved room of user not authentication', () => {
        return request
            .get('/saved-rooms')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized')
            });
    });

    it('Test get all saved room of user', () => {
        return request
            .get('/saved-rooms')
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });
});
