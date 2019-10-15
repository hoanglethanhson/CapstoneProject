import AuthFunction from '../functions/auth-function';

export default [
  {
    path: '/auth/register',
    method: 'post',
    authentication: true,
    handler: AuthFunction.createUser,
  },
  {
    path: '/auth/verifyPhoneNumber',
    method: 'post',
    authentication: true,
    handler: AuthFunction.verifyPhoneNumber,
  },
  {
    path: '/auth/login',
    method: 'post',
    authentication: true,
    handler: AuthFunction.signIn,
  },
];
