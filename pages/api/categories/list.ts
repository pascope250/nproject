import { NextApiRequest, NextApiResponse } from 'next'
import prisma from '@/lib/prisma'
import cache from '@/lib/redisCache'
import { cacheKeys, cacheNameSpace } from '@/types/cacheType'

const ALLOWED_ORIGINS = [
  process.env.NEXT_FRONTEND_BASE,
  'https://npfrontend-opp7.vercel.app',
  'https://hobbyvb.com',
  'https://www.hobbyvb.com', // 🔧 Added https:// to fix match
  'http://localhost:3001',
].filter(Boolean)

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  // --- Dynamic CORS Handling ---
  const origin = req.headers.origin
  if (origin && ALLOWED_ORIGINS.includes(origin)) {
    res.setHeader('Access-Control-Allow-Origin', origin)
  }
  res.setHeader('Access-Control-Allow-Methods', 'GET,POST,PUT,DELETE,OPTIONS')
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization')
  res.setHeader('Access-Control-Allow-Credentials', 'true')
  
  if (req.method === 'OPTIONS') return res.status(200).end()
  // --- End CORS ---

  try {
    switch (req.method) {
      case 'GET': {
        // 1. Try reading from Redis
        const cachedCategories = await cache.get(cacheNameSpace.category, cacheKeys.category);
        if (cachedCategories) {
          return res.status(200).json(cachedCategories)
        }
        // 2. Fetch from DB
        const categories = await prisma.categories.findMany({
          orderBy: { createdAt: 'desc' },
        })

        const newCategories = categories.map(cat => ({
          id: cat.id,
          name: cat.name,
        }))

        // 3. Save to cache (3 days)
        await cache.save(cacheNameSpace.category, cacheKeys.category, newCategories, { ttl: 259200 })

        return res.status(200).json(newCategories)
      }

      default:
        res.setHeader('Allow', ['GET'])
        return res.status(405).json({ message: `Method ${req.method} not allowed` })
    }
  } catch (err) {
    console.error('API Error:', err)

    if (err instanceof Error && err.message.includes('RecordNotFound')) {
      return res.status(404).json({ message: 'Category not found' })
    }

    return res.status(500).json({
      message: 'Internal server error',
      error: process.env.NODE_ENV === 'development' && err instanceof Error ? err.message : undefined,
    })
  }
}
