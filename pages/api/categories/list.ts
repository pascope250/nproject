import { NextApiRequest, NextApiResponse } from 'next';
import prisma from '@/lib/prisma';
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

  try {
    switch (req.method) {
      case 'GET':
        // Get all categories
        const categories = await prisma.categories.findMany({
          orderBy: { createdAt: 'desc' }
        });

        const newCategories = categories.map((cat) => {
            return{
                id: cat.id,
                name: cat.name
            }
        });
        return res.status(200).json(newCategories);

      default:
        res.setHeader('Allow', ['GET', 'POST', 'PUT', 'DELETE']);
        return res.status(405).json({
          message: `Method ${req.method} not allowed`
        });
    }
  } catch (err) {
    console.error('API Error:', err);
    
    // Handle Prisma specific errors
    if (err instanceof Error && err.message.includes('RecordNotFound')) {
      return res.status(404).json({ message: 'Category not found' });
    }

    return res.status(500).json({ 
      message: 'Internal server error',
      error: process.env.NODE_ENV === 'development' && err instanceof Error ? err.message : undefined
    });
  }
}