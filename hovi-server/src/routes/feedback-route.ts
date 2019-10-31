import feedbackFunction from "../functions/feedback-function";

export default [
    {
        path: "/feedback/",
        method: "get",
        handler: feedbackFunction.getFeedbacks
    },
    {
        path: "/feedback/:feedbackId",
        method: "get",
        handler: feedbackFunction.getFeedback
    },
    {
        path: "/feedback/",
        method: "post",
        authentication: true,
        handler: feedbackFunction.createFeedback
    },
    {
        path: "/feedback/:feedbackId",
        method: "put",
        authentication: true,
        handler: feedbackFunction.updateFeedback
    },
    {
        path: "/feedback/:feedbackId",
        method: "delete",
        authentication: true,
        handler: feedbackFunction.deleteFeedback
    },
];
