import type { NextApiRequest, NextApiResponse } from 'next';
import prisma from '@/lib/prisma';
import cache from '@/lib/redisCache';
import { cacheKeys, cacheNameSpace } from '@/types/cacheType';
interface ReplyRequest {
  userName: string;
  content: string;
}
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
  const { commentId } = req.query;

  if (req.method !== 'POST') {
    res.setHeader('Allow', ['POST']);
    return res.status(405).json({ error: `Method ${req.method} Not Allowed` });
  }
  

  try {
    const { userName, content } = req.body as ReplyRequest;

    if (!userName || !content) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    const reply = await prisma.replies.create({
      data: {
        commentId: Number(commentId),
        userName,
        content,
      },
    });
    await cache.delete(cacheNameSpace.comment, cacheKeys.comment);
    return res.status(201).json(reply);
  } catch (error) {
    console.error('Reply API error:', error);
    return res.status(500).json({ error: 'Internal Server Error' });
  } finally {
    await prisma.$disconnect();
  }
}