import { jest } from '@jest/globals';
import { S3Service } from '@services/S3.service';
import AWSMock from 'mock-aws-s3';
jest.mock('aws-sdk', () => AWSMock);
process.env.BUCKET = 'deel_local_test';
export const TEST_FILE_KEY = 'fileKey';
export const EXTRA_TEST_FILE_KEY = 'extraFileKey';
export const TEST_FILE_PATH = '/test/';

export const S3ServiceMock = S3Service;
