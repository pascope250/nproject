import type { NextApiRequest, NextApiResponse } from 'next';
import prisma from '@/lib/prisma';
// import redis from '@/lib/redis';
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
        // Get all comments with replies
        const comments = await prisma.comments.findMany({
          orderBy: { createdAt: 'desc' },
          include: {
            replies: {
              orderBy: { createdAt: 'asc' }
            }
          }
        });
        return res.status(200).json(comments);
      }
      case 'DELETE': {
        const { commentId } = req.body;
        if (!commentId) {
          return res.status(400).json({ message: 'commentId is required' });
        }
        const deletedComment = await prisma.comments.delete({
          where: { id: commentId }
        });

        // await redis.delete('comments','all');
        return res.status(200).json(deletedComment);
      }

      case 'POST': {
        const { userName, comment, movieId } = req.body;
        if (!userName || !comment || !movieId) {
          return res.status(400).json({ message: 'userName and comments are required' });
        }
        const newComment = await prisma.comments.create({
          data: {
            userName,
            comment,
            movieId,
            createdAt: new Date(),
            commentLike: 0
          }
        });
        // await redis.delete('comments','all');
        return res.status(201).json(newComment);
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