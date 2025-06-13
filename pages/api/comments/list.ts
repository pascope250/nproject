import type { NextApiRequest, NextApiResponse } from 'next';
import prisma from '@/lib/prisma';
const INTERFACE_URL = process.env.NEXT_FRONTEND_BASE;
import redis from '@/lib/redis';
export default async function handler(req: NextApiRequest, res: NextApiResponse) {
   // --- CORS for http://localhost:3001 ---
  res.setHeader('Access-Control-Allow-Origin', INTERFACE_URL || 'https://npfrontend-opp7.vercel.app');
  res.setHeader('Access-Control-Allow-Methods', 'GET,POST,PUT,DELETE,OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
  res.setHeader('Access-Control-Allow-Credentials', 'true');

  // Handle preflight OPTIONS request
  if (req.method === 'OPTIONS') {
    return res.status(200).end();
  }
  // --- End CORS ---
  try {
    switch (req.method) {
      case 'GET': {
        // get comments from redis
        const cachedComments = await redis.get('comments','all');
        if (typeof cachedComments === 'string') {
          return res.status(200).json(JSON.parse(cachedComments));
        }
        // Get all comments with replies
        const comments = await prisma.comments.findMany({
          orderBy: { createdAt: 'desc' },
          include: {
            replies: {
              orderBy: { createdAt: 'desc' }
            }
          }
        });
        // set comments to redis
        await redis.save('comments','all',JSON.stringify(comments));
        return res.status(200).json(comments);
      }     

      default:
        res.setHeader('Allow', ['GET', 'POST']);
        return res.status(405).json({ message: `Method ${req.method} not allowed` });
    }
  } catch (err) {
    console.error('API Error:', err);
    return res.status(500).json({
      message: 'Internal server error',
      error: process.env.NODE_ENV === 'development' && err instanceof Error ? err.message : undefined
    });
  }
}