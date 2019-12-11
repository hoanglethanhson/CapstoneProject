import AuthFunction from '../functions/auth-function';

export default [
    {
        path: '/auth/register',
        method: 'post',
        handler: AuthFunction.createUser,
    },
    {
        path: '/auth/login',
        method: 'post',
        handler: AuthFunction.signIn,
    },
    {
        path: '/auth/reset-password',
        method: 'post',
        handler: AuthFunction.resetPassword,
    },
    {
        path: '/auth/forgot-password',
        method: 'post',
        handler: AuthFunction.sendResetPasswordEmail,
    },
    {
        path: '/auth/verify-email',
        method: 'post',
        handler: AuthFunction.verifyEmail,
    },
    {
        path: '/auth/verify-phone-number',
        method: 'post',
        handler: AuthFunction.verifyPhoneNumber,
    },
    {
        path: "/auth/change-password",
        method: "post",
        authentication: true,
        handler: AuthFunction.changePassword
    },
];
