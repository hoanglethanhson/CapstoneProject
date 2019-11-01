import TenantReviewFunction from "../functions/tenant-review-function";

export default [
    {
        path: "/tenantReview/",
        method: "get",
        handler: TenantReviewFunction.getTenantReviews
    },
    {
        path: "/tenantReview/:tenantReviewId",
        method: "get",
        handler: TenantReviewFunction.getTenantReview
    },
    {
        path: "/tenantReview/",
        method: "post",
        authentication: true,
        handler: TenantReviewFunction.createTenantReview
    },
    {
        path: "/tenantReview/:tenantReviewId",
        method: "put",
        authentication: true,
        handler: TenantReviewFunction.updateTenantReview
    },
    {
        path: "/tenantReview/:tenantReviewId",
        method: "delete",
        authentication: true,
        handler: TenantReviewFunction.deleteTenantReview
    },
];
