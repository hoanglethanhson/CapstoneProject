const admin = require('firebase-admin');
import * as serviceAccount from "./private_key/firebase-service-account.json";

const FirebaseApp = !admin.apps.length ?
  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: 'https://test-2-71ffb.firebaseio.com',
  }) : admin.app();

export default FirebaseApp;
