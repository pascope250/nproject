import { NextApiRequest, NextApiResponse } from 'next';
import prisma from '../../lib/prisma';
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
      case 'POST':
        // Validate request body
        const { movieId, name, domain, type, part, baseUrl } = req.body;
        
        if (!name || !domain || !type || !part || !baseUrl) {
          return res.status(400).json({ 
            message: 'Valid source name is required',
            error: 'Invalid name format'
          });
        }

        // Create new category
        const newSource = await prisma.sources.create({
          data: {
            movieId,
            name,
            domain,
            type,
            part,
            baseUrl}
        });

        await cache.delete(cacheNameSpace.comment, cacheKeys.comment)
        
        return res.status(201).json(newSource);

      case 'GET':
        // Get all categories
        const sourceRes = await prisma.sources.findMany();
        return res.status(200).json(sourceRes);

      case 'PUT':
        // Update category
        const {id, EditmovieId, Editname, Editdomain, Edittype, Editpart, EditbaseUrl } = req.body;

        if (!id || !Editname || !Editdomain || !Edittype || !Editpart || !EditbaseUrl) {
          return res.status(400).json({ 
            message: 'Valid category ID and new name are required',
            error: 'Invalid request format'
          });
        }
        const updatedSource = await prisma.sources.update({
          where: { id: Number(id) }, // Convert to number if your ID is Int
          data: { 
            movieId: EditmovieId,
            name: Editname,
            domain: Editdomain,
            type: Edittype,
            part: Editpart,
            baseUrl: EditbaseUrl,
           },
        });

        await cache.delete(cacheNameSpace.comment, cacheKeys.comment)
        return res.status(200).json(updatedSource);

      case 'DELETE':
        // Delete category - now properly implemented
        const { SourceId } = req.body; // Typically DELETE uses query params

        if (!SourceId || typeof SourceId === 'string') {
          return res.status(400).json({
            message: 'Valid Source ID is required',
          });
        }

        await prisma.sources.delete({
          where: { id: Number(SourceId) },
        });
        await cache.delete(cacheNameSpace.comment, cacheKeys.comment);
        return res.status(204).end(); // 204 No Content is standard for DELETE

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
      return res.status(404).json({ message: 'Source not found' });
    }

    return res.status(500).json({ 
      message: 'Internal server error',
      error: process.env.NODE_ENV === 'development' && err instanceof Error ? err.message : undefined
    });
  }
}