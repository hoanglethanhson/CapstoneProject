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
}
