import TenantReviewFunction from "../functions/tenant-review-function";

export default [
    {
        path: "/tenantReview/",
        method: "get",
        authentication: false,
        handler: TenantReviewFunction.getTenantReviews
    },
    {
        path: "/tenantReview/:tenantReviewId",
        method: "get",
        authentication: false,
        handler: TenantReviewFunction.getTenantReview
    },
    {
        path: "/tenantReview/",
        method: "post",
        authentication: false,
        handler: TenantReviewFunction.createTenantReview
    },
    {
        path: "/tenantReview/:tenantReviewId",
        method: "put",
        authentication: false,
        handler: TenantReviewFunction.updateTenantReview
    },
    {
        path: "/tenantReview/:tenantReviewId",
        method: "delete",
        authentication: false,
        handler: TenantReviewFunction.deleteTenantReview
    },
];
