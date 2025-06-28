import type { NextApiRequest, NextApiResponse } from 'next';
import prisma from '@/lib/prisma';
import cache from '@/lib/redisCache';
import { cacheKeys, cacheNameSpace } from '@/types/cacheType';
const ALLOWED_ORIGINS = [
  process.env.NEXT_FRONTEND_BASE,
  'https://npfrontend-opp7.vercel.app',
  'https://hobbyvb.com',
  'http://localhost:3001', // Add more domains as needed
].filter(Boolean); // Remove undefined values

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
 // --- Dynamic CORS Handling ---
  const origin = req.headers.origin;
  if (origin && ALLOWED_ORIGINS.includes(origin)) {
    res.setHeader('Access-Control-Allow-Origin', origin);
  }
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
      // if comments exist in caches, return them
      const cachedComment = await cache.get(cacheNameSpace.comment, cacheKeys.comment);
      if(cachedComment){
        return res.status(200).json(cachedComment);
      }
        const comments = await prisma.comments.findMany({
          orderBy: { createdAt: 'desc' },
          include: {
            replies: {
              orderBy: { createdAt: 'desc' }
            }
          }
        });
       await cache.save(cacheNameSpace.comment, cacheKeys.comment, comments, {ttl: 259200});
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