export class ConstantValues {
    static readonly DEFAULT_ADDRESS = 'not yet';
    static readonly DEFAULT_FACEBOOK_ID = 'example-facebook-id';
    static readonly DEFAULT_GOOGLE_ID = 'example-google-id';
    static readonly DEFAULT_AVATAR = 'https://img.icons8.com/pastel-glyph/64/000000/person-male.png';
    static readonly DEFAULT_EMAIL = 'your_email@example.com';

    // DEFINE ROOM GROUP FIELDS
    static readonly DIRECTION = ['Bắc', 'Nam', 'Đông', 'Tây', 'Đông Bắc', 'Đông Nam', 'Tây Bắc', 'Tây Nam'];

    // DEFINE ROOM STATUS
    static readonly ROOM_WAS_DELETED = -1;
    static readonly ROOM_NOT_AVAILABLE = 0;
    static readonly ROOM_AVAILABLE = 1;

    //DEFINE USER TYPE
    static readonly TENANT = 1;
    static readonly HOST = 2;
    static readonly ADMIN = 3;

    //DEFINE TRANSACTION STATUS
    static readonly DUMMY_STATUS = 0;
    static readonly ACCEPT_WAITING = 1;
    static readonly HOST_REJECTED = -1;
    static readonly NOT_ENOUGH_BALANCE = -2;
    static readonly ENOUGH_BALANCE = 2;
    static readonly EXPIRE_FAILED = -3;
    static readonly HOST_DEPOSIT_TRANSFERRED = 3;

    //DEFINE ADMIN USER INFO
    static readonly ADMIN_USER_ID = 1;
    static readonly ADMIN_BANK = "TPBank";
    static readonly ADMIN_ACCOUNT_NUMBER = "02725034001";
}
