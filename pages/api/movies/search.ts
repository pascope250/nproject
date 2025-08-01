import { NextApiRequest, NextApiResponse } from 'next';
import prisma from '@/lib/prisma';
import cache from '@/lib/redisCache';
import { cacheKeys, cacheNameSpace } from '@/types/cacheType';
import { Prisma } from '@prisma/client';

const IMAGE_BASE_URL = `${process.env.NEXT_PUBLIC_BASE_URL}/posters`;

export const config = {
    api: {
        bodyParser: {
            sizeLimit: '10mb' // Increase limit for image uploads
        }
    }
};

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
  const { query } = req.query;

  // Validate and sanitize the query
  const searchTerm = query?.toString().trim().toLowerCase() || '';

  // Build the database query with proper typing
  const whereCondition: Prisma.moviesWhereInput = searchTerm 
    ? {
        OR: [
          { title: { contains: searchTerm, mode: 'insensitive' as const } },
          { description: { contains: searchTerm, mode: 'insensitive' as const } },
          { category: { name: { contains: searchTerm, mode: 'insensitive' as const } } },
          ...(isNaN(Number(searchTerm)) ? [] : [{ year: Number(searchTerm) }])
        ]
      }
    : {};

  // Get movies with pagination and search filtering at database level
  const movies = await prisma.movies.findMany({
    where: whereCondition,
    orderBy: { createdAt: 'desc' },
    take: 10,
    include: {
      category: {
        select: {
          name: true
        }
      },
      sources: true
    }
  });

  // Transform movies data
  const transformedMovies = movies.map((movie) => ({
    id: movie.id,
    categoryId: movie.categoryId,
    type: movie.type,
    categoryName: movie.category.name,
    title: movie.title,
    description: movie.description || '',
    year: movie.year,
    rating: movie.rating,
    poster: movie.poster.startsWith('http') 
      ? movie.poster 
      : `${IMAGE_BASE_URL}/${movie.poster}`,
    createdAt: movie.createdAt,
  }));

  return res.status(200).json(transformedMovies);
}

            default:
                res.setHeader('Allow', ['GET']);
                return res.status(405).json({
                    message: `Method ${req.method} not allowed`
                });
        }
    } catch (err) {
        console.error('API Error:', err);

        if (err instanceof Error) {
            if (err.message.includes('RecordNotFound')) {
                return res.status(404).json({ message: 'Movie not found' });
            }
            if (err.message.includes('Unique constraint')) {
                return res.status(409).json({ message: 'Movie with this title already exists' });
            }
        }
        return res.status(500).json({
            message: 'Internal server error',
            error: process.env.NODE_ENV === 'development' && err instanceof Error ? err.message : undefined
        });
    }
}