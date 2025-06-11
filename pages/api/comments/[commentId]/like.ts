import type { NextApiRequest, NextApiResponse } from 'next';
import prisma from '@/lib/prisma';
import redis from '@/lib/redis';
const INTERFACE_URL = process.env.NEXT_FRONTEND_BASE;
export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {

      // --- CORS for http://localhost:3001 ---
  res.setHeader('Access-Control-Allow-Origin', INTERFACE_URL || 'http://localhost:3001');
  res.setHeader('Access-Control-Allow-Methods', 'GET,POST,PUT,DELETE,OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
  res.setHeader('Access-Control-Allow-Credentials', 'true');

  // Handle preflight OPTIONS request
  if (req.method === 'OPTIONS') {
    return res.status(200).end();
  }
  // --- End CORS ---
  if (req.method !== 'POST') {
    res.setHeader('Allow', ['POST']);
    return res.status(405).json({ error: `Method ${req.method} Not Allowed` });
  }

  try {
    const { commentId } = req.query;
    const ip = req.headers['x-forwarded-for'] || req.socket.remoteAddress;
    
    // Validate commentId
    if (!commentId || isNaN(Number(commentId))) {
      return res.status(400).json({ error: 'Invalid comment ID' });
    }

    if (!ip || Array.isArray(ip)) {
      return res.status(400).json({ error: 'Could not determine IP address' });
    }

    // Check if IP already liked this comment
    const existingLike = await prisma.commentlike.findFirst({
      where: {
        commentId: Number(commentId),
        ip: ip as string,
      },
    });

    if (existingLike) {
      return res.status(400).json({ error: 'You already liked this comment' });
    }

    // Create the like record and increment count in a transaction
    const [like, updatedComment] = await prisma.$transaction([
      prisma.commentlike.create({
        data: {
          commentId: Number(commentId),
          ip: ip as string,
        },
      }),
      prisma.comments.update({
        where: { id: Number(commentId) },
        data: { commentLike: { increment: 1 } },
      }),
    ]);

    await redis.delete('comments','all');

    return res.status(200).json({ 
      success: true,
      likes: updatedComment.commentLike,
    });

  } catch (error) {
    console.error('Like API error:', error);
    return res.status(500).json({ error: 'Internal Server Error' });
  } finally {
    await prisma.$disconnect();
  }
}