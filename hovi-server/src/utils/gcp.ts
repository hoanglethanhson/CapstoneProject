import config from '../../config';

const { Storage } = require('@google-cloud/storage');

export default class {
  storage: any;
  bucketName: any;
  bucket: any;

  constructor(bucketName) {
    this.storage = new Storage({
      projectId: config.GOOGLE_CLOUD_PROJECT_ID,
      keyFilename: './config/private-key/gcp-service-account.json'
    });
    this.bucketName = bucketName;
    this.bucket = this.storage.bucket(bucketName);
  }

  getPublicUrl(fileName) {
    return { url: `https://storage.googleapis.com/${this.bucketName}/${fileName}` };
  }

  uploadFileToGoogleStoragePromise(file: any, roomGroupId: number, uniqueId: any) {
    return new Promise((resolve, reject) => {
      const gcsFileName = `room-image-${roomGroupId}-${uniqueId}`;
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
      }).end(file.buffer);

    });
  }
}
