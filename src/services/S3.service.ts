import Config from '@services/config';
import { S3 } from 'aws-sdk';
import { Service } from 'typedi';

export const S3_TARGET_DIR = 'swagger-files';

@Service()
export class S3Service {
  readonly bucketName = Config.S3_BUCKET;
  readonly serviceS3Dir = Config.S3_DIR;

  s3Client: S3;

  constructor(s3Client?: S3) {
    this.s3Client = s3Client ? s3Client : new S3();
  }

  get pathToCopy() {
    return `${this.serviceS3Dir}/${S3_TARGET_DIR}`;
  }

  async copyFromSource(fileKey: string, sourceKey: string) {
    try {
      await this.s3Client
        .copyObject({
          CopySource: encodeURIComponent(sourceKey), // the source should contain the bucket name
          Key: `${this.pathToCopy}/${fileKey}`,
          Bucket: this.bucketName
        })
        .promise();
    } catch (error) {
      log.error({ message: `Failed to copy from source`, key: fileKey, sourceKey, bucketName: this.bucketName, error });
      throw error;
    }
  }

  async deleteFile(fileKey: string) {
    const path = `${this.serviceS3Dir}/${S3_TARGET_DIR}`;
    return await this.s3Client.deleteObject({ Key: `${path}/${fileKey}`, Bucket: this.bucketName }).promise();
  }

  async getSignedUrl(key: string) {
    return await this.s3Client.getSignedUrlPromise('getObject', {
      Bucket: this.bucketName,
      Key: key,
      Expires: 15 * 60,
      ResponseContentDisposition: `attachment;filename="${key}"`
    });
  }
}
