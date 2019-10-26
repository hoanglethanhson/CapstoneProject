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
        handler: feedbackFunction.createFeedback
    },
    {
        path: "/feedback/:feedbackId",
        method: "put",
        handler: feedbackFunction.updateFeedback
    },
    {
        path: "/feedback/:feedbackId",
        method: "delete",
        handler: feedbackFunction.deleteFeedback
    },
];
