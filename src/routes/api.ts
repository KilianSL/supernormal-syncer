import { Router, Request, Response } from 'express';
import { logger } from '../utils/logger';

const router = Router();

/**
 * GET /api
 * Root endpoint for the API
 */
router.get('/', (req: Request, res: Response) => {
  logger.info('API root endpoint accessed');
  res.json({
    message: 'Welcome to the TypeScript Node.js API',
    version: '1.0.0',
    endpoints: [
      {
        path: '/api',
        method: 'GET',
        description: 'API information',
      },
      {
        path: '/api/status',
        method: 'GET',
        description: 'Get API status',
      },
    ],
  });
});

/**
 * GET /api/status
 * Status endpoint for the API
 */
router.get('/status', (req: Request, res: Response) => {
  logger.info('Status endpoint accessed');
  res.json({
    status: 'online',
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
    memory: process.memoryUsage(),
  });
});

export default router; 