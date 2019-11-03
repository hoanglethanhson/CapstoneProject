export class ConstantValues {
  static readonly DEFAULT_EMAIL = 'example@homohouse.vn';
  static readonly DEFAULT_ADDRESS = 'not yet';
  static readonly DEFAULT_FACEBOOK_ID = 'example-facebook-id';
  static readonly DEFAULT_GOOGLE_ID = 'example-google-id';

  // DEFINE ROOM STATUS
  static readonly ROOM_WAS_DELETED = -1;
  static readonly ROOM_NOT_AVAILABLE = 0;
  static readonly ROOM_AVAILABLE = 1;

  //DEFINE USER TYPE
  static readonly TENANT = 1;
  static readonly HOST = 2;
  static readonly ADMIN = 3;

  //DEFINE TRANSACTION STATUS
  static readonly ACCEPT_WAITING = 0;
  static readonly HOST_REJECTED = -1;
  static readonly NOT_ENOUGH_BALANCE = -2;
  static readonly ENOUGH_BALANCE = 1;
  static readonly EXPIRE_FAILED = -3;
  static readonly HOST_DEPOSIT_TRANSFERRED = 2;

  //DEFINE ADMIN USER INFO
  static readonly ADMIN_USER_ID = 5;
  static readonly ADMIN_BANK = "TPBank";
  static readonly ADMIN_ACCOUNT_NUMBER = "02725034001";
}
