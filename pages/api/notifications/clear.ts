import type { NextApiRequest, NextApiResponse } from 'next';
import { authMiddleware } from '@/middleware/adminJwtMiddleware';
import prisma from '@/lib/prisma';

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    // Apply auth middleware
    await authMiddleware(req, res);
    await prisma.usernotifications.deleteMany();
    await prisma.notification.deleteMany();
    res.status(200).json({ success: true });
  } catch (error) {
    console.error('Clear notifications error:', error);
    res.status(500).json({ error: 'Failed to clear notifications' });
  }
}