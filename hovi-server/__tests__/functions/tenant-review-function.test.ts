import server from '../../src/server-test';
import AuthFunction from "../../src/functions/auth-function";
import {DatabaseManager} from "../../src/models";

const supertest = require('supertest');

describe('Test function tenantReview', () => {
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

    it('Test get all tenantReviews', () => {
        return request
            .get('/tenantReview')
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test get tenantReview by review Id', () => {
        return request
            .get('/tenantReview/1')
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test get all tenantReviews without authentication', () => {
        return request
            .get('/tenantReview')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized');
            });
    });

    it('Test get tenantReview by review Id without authentication', () => {
        return request
            .get('/tenantReview/1')
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized');
            });
    });

    it('Test create tenantReview money transfer content with authentication', () => {
        return request
            .post('/tenantReview/')
            .send({userId: 1, roomGroupId: 35, comment: 'nice', accuracyStar: 3, hostStar: 3, securityStar: 3})
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test create tenantReview money transfer content without authentication', () => {
        return request
            .post('/tenantReview/')
            .send({userId: 1, roomGroupId: 35, comment: 'nice', accuracyStar: 3, hostStar: 3, securityStar: 3})
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized');
            });
    });

    it('Test create tenantReview money transfer content with authentication', () => {
        return request
            .put('/tenantReview/1')
            .send({userId: 1, roomGroupId: 35, comment: 'updated', accuracyStar: 3, hostStar: 3, securityStar: 3})
            .set('Authorization', token)
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(200);
            });
    });

    it('Test create tenantReview money transfer content without authentication', () => {
        return request
            .put('/tenantReview/1')
            .send({userId: 1, roomGroupId: 35, comment: 'updated', accuracyStar: 3, hostStar: 3, securityStar: 3})
            .set('Accept', 'application/json')
            .then(response => {
                expect(response.status).toBe(401);
                expect(response.body.message).toBe('Unauthorized');
            });
    });

});
