require('dotenv/config');

process.env.TEST = 1;
process.env.LOG_LEVEL = 'info';
process.env.ASYNC_CONTEXT = 1;
process.env.BACKEND_URL = 'http://backend-benefits';
process.env.NATS_URL = 'nats://0.0.0.0:4222';