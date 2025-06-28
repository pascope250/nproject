import type { NextApiRequest, NextApiResponse } from 'next';
import prisma from '@/lib/prisma';
import cache from '@/lib/redisCache';
import { cacheKeys, cacheNameSpace } from '@/types/cacheType';

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  const { commentId } = req.query;

  try {
    switch (req.method) {
      case 'DELETE':
        await handleDelete(Number(commentId), res);
        await cache.delete(cacheNameSpace.comment, cacheKeys.comment);
        res.status(200).json({ message: 'Comment deleted successfully' });
        break;
      default:
        res.setHeader('Allow', ['DELETE']);
        res.status(405).json({ error: `Method ${req.method} Not Allowed` });
    }
  } catch (error) {
    console.error('Comment API error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  } finally {
    await prisma.$disconnect();
  }
}

async function handleDelete(commentId: number, res: NextApiResponse) {
  // First delete all replies associated with this comment
  await prisma.replies.deleteMany({
    where: { commentId }
  });

  // Then delete the comment itself
  const deletedComment = await prisma.comments.delete({
    where: { id: commentId }
  });

  res.status(200).json(deletedComment);
}