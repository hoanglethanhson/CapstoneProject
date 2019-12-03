import hostReviewFunction from "../functions/host-review-function";

export default [
    {
        path: "/hostReview/",
        method: "get",
        handler: hostReviewFunction.getHostReviews
    },
    {
        path: "/hostReview/:reviewId",
        method: "get",
        handler: hostReviewFunction.getHostReview
    },
    {
        path: "/hostReviewsOfTenant/:tenantId",
        method: "get",
        handler: hostReviewFunction.getHostReviewByTenantId
    },
    {
        path: "/hostReview/",
        method: "post",
        authentication: true,
        handler: hostReviewFunction.createHostReview
    },
    {
        path: "/hostReview/:hostReviewId",
        method: "put",
        authentication: true,
        handler: hostReviewFunction.updateHostReview
    },
    {
        path: "/hostReview/:hostReviewId",
        method: "delete",
        authentication: true,
        handler: hostReviewFunction.deleteHostReview
    },
];
