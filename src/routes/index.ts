import { Router } from 'express';
const router: Router = Router();

// API routes
router.use('/api', (req, res) => {
  res.status(404).json({ error: 'API routes not implemented yet' });
});

export default router; 