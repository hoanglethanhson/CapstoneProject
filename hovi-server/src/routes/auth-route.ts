import AuthFunction from '../functions/auth-function';

export default [
  {
    path: '/auth/register',
    method: 'post',
    handler: AuthFunction.createUser,
  },
  {
    path: '/auth/verifyPhoneNumber',
    method: 'post',
    handler: AuthFunction.verifyPhoneNumber,
  },
  {
    path: '/auth/login',
    method: 'post',
    handler: AuthFunction.signIn,
  },
];
