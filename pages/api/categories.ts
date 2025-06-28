import { NextApiRequest, NextApiResponse } from 'next';
import prisma from '../../lib/prisma';
import cache from '@/lib/redisCache';
import { cacheKeys, cacheNameSpace } from '@/types/cacheType';
export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  try {
    switch (req.method) {
      case 'POST':
        // Validate request body
        const { name } = req.body;
        
        if (!name || typeof name !== 'string') {
          return res.status(400).json({ 
            message: 'Valid category name is required',
            error: 'Invalid name format'
          });
        }

        // Create new category
        const newCategory = await prisma.categories.create({
          data: { name }
        });
        await cache.delete(cacheNameSpace.category, cacheKeys.category);
        
        return res.status(201).json(newCategory);

      case 'GET':
        // get data from caches
        const getDataFromCache = await cache.get(cacheNameSpace.category, cacheKeys.category);
        if (getDataFromCache) {
          return res.status(200).json(getDataFromCache);
        }
        // Get all categories
        const categories = await prisma.categories.findMany({
          orderBy: { createdAt: 'desc' }
        });
        await cache.save(cacheNameSpace.category, cacheKeys.category, categories, {ttl: 259200});
        return res.status(200).json(categories);

      case 'PUT':
        // Update category
        const { id, newName } = req.body;

        if (!id || typeof newName !== 'string') {
          return res.status(400).json({ 
            message: 'Valid category ID and new name are required',
            error: 'Invalid request format'
          });
        }

        const updatedCategory = await prisma.categories.update({
          where: { id: Number(id) }, // Convert to number if your ID is Int
          data: { name: newName },
        });

        await cache.delete(cacheNameSpace.category, cacheKeys.category);

        return res.status(200).json(updatedCategory);

      case 'DELETE':
        // Delete category - now properly implemented
        const { categoryId } = req.body; // Typically DELETE uses query params

        if (!categoryId || typeof categoryId === 'string') {
          return res.status(400).json({
            message: 'Valid category ID is required',
          });
        }

        await prisma.categories.delete({
          where: { id: Number(categoryId) },
        });

        await cache.delete(cacheNameSpace.category, cacheKeys.category);

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
      return res.status(404).json({ message: 'Category not found' });
    }

    return res.status(500).json({ 
      message: 'Internal server error',
      error: process.env.NODE_ENV === 'development' && err instanceof Error ? err.message : undefined
    });
  }
}