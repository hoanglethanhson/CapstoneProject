import * as serviceAccount from './private_key/gcp-service-account.json'; // WARNING: DON'T REMOVE THIS
import config from '../../config';
import { getCurrentDate } from './index';
import path from 'path';

const { Storage } = require('@google-cloud/storage');

export default class {
  storage: any;
  bucketName: any;
  bucket: any;

  constructor(bucketName) {
    this.storage = new Storage({
      projectId: config.GOOGLE_CLOUD_PROJECT_ID,
      keyFilename: path.join(__dirname, './private_key/gcp-service-account.json'),
    });
    this.bucketName = bucketName;
    this.bucket = this.storage.bucket(bucketName);
  }

  getPublicUrl(fileName) {
    return `https://storage.googleapis.com/${this.bucketName}/${fileName}`;
  }

  uploadFileToGoogleStoragePromise(file: any, roomGroupId: number) {
    return new Promise((resolve, reject) => {
      const { originalname, buffer, mimetype } = file;
      console.log(file);

      const gcsFileName = `${getCurrentDate()}-${roomGroupId}-${originalname}`;
      const bucketFile = this.bucket.file(gcsFileName);

      bucketFile.createWriteStream('')
        .on('error', error => {
          console.log(error);
          reject(error);
        }).on('finish', () => {
        bucketFile.makePublic().then((data) => {
          console.log(data);
          resolve(this.getPublicUrl(gcsFileName));
        });
      }).end(buffer);

    });
  }
}
