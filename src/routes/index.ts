import { Router } from 'express';
import apiRoutes from './api';

const router = Router();

// API routes
router.use('/api', apiRoutes);

export default router; 