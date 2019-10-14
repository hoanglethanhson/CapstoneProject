import AuthFunction from '../functions/auth-function';

export default [
  {
    path: '/auth/register',
    method: 'post',
    authentication: false,
    handler: AuthFunction.createUser,
  },
  {
    path: '/auth/verifyPhoneNumber',
    method: 'post',
    authentication: false,
    handler: AuthFunction.verifyPhoneNumber,
  },
  {
    path: '/auth/login',
    method: 'post',
    authentication: false,
    handler: AuthFunction.signIn,
  },
];
