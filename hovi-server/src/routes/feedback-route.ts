import feedbackFunction from "../functions/feedback-function";

export default [
    {
        path: "/feedback/",
        method: "get",
        authentication: false,
        handler: feedbackFunction.getFeedbacks
    },
    {
        path: "/feedback/:feedbackId",
        method: "get",
        authentication: false,
        handler: feedbackFunction.getFeedback
    },
    {
        path: "/feedback/",
        method: "post",
        authentication: false,
        handler: feedbackFunction.createFeedback
    },
    {
        path: "/feedback/:feedbackId",
        method: "put",
        authentication: false,
        handler: feedbackFunction.updateFeedback
    },
    {
        path: "/feedback/:feedbackId",
        method: "delete",
        authentication: false,
        handler: feedbackFunction.deleteFeedback
    },
];
