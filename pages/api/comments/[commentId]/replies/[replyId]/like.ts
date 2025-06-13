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
  if (req.method !== 'POST') {
    res.setHeader('Allow', ['POST']);
    return res.status(405).json({ error: `Method ${req.method} Not Allowed` });
  }

  try {
    const { commentId, replyId } = req.query;
    const ip = req.headers['x-forwarded-for'] || req.socket.remoteAddress;

    // Validate IDs
    if (!commentId || isNaN(Number(commentId))) {
      return res.status(400).json({ error: 'Invalid comment ID' });
    }

    if (!replyId || isNaN(Number(replyId))) {
      return res.status(400).json({ error: 'Invalid reply ID' });
    }

    if (!ip || Array.isArray(ip)) {
      return res.status(400).json({ error: 'Could not determine IP address' });
    }

    // Check if reply exists and belongs to the comment
    const existingReply = await prisma.replies.findFirst({
      where: {
        id: Number(replyId),
        commentId: Number(commentId),
      },
    });
    

    if (!existingReply) {
      return res.status(404).json({ error: 'Reply not found' });
    }

    // Check if IP already liked this reply
    const existingLike = await prisma.replylikes.findFirst({
      where: {
        replyId: Number(replyId),
        ip: ip as string,
      },
    });

    if (existingLike) {
      return res.status(400).json({ error: 'You already liked this reply' });
    }

    // Create the like record and increment count in a transaction
    const [like, updatedReply] = await prisma.$transaction([
      prisma.replylikes.create({
        data: {
          replyId: Number(replyId),
          ip: ip as string,
        },
      }),
      prisma.replies.update({
        where: { id: Number(replyId) },
        data: { replyLike: { increment: 1 } },
      }),
    ]);
    // await redis.delete('comments','all');
    return res.status(200).json({ 
      success: true,
      likes: updatedReply.replyLike,
    });

  } catch (error) {
    console.error('Reply Like API error:', error);
    return res.status(500).json({ error: 'Internal Server Error' });
  }
}