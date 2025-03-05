import { Request, Response, NextFunction } from 'express';
import { logger } from '../utils/logger';

/**
 * Middleware to authenticate requests using an API key
 */
export const apiKeyAuth = (req: Request, res: Response, next: NextFunction): void => {
  // Get the API key from the request header
  const apiKey = req.header('X-API-KEY');
  
  // Get the expected API key from environment variables
  const expectedApiKey = process.env.API_KEY;
  
  // Check if API key is provided and matches expected value
  if (!apiKey || apiKey !== expectedApiKey) {
    logger.warn(`Invalid API key attempt from ${req.ip}`);
    res.status(401).json({ error: 'Unauthorized: Invalid API key' });
    return;
  }
  
  // API key is valid, proceed to the next middleware
  next();
}; 