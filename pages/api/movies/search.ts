import { NextApiRequest, NextApiResponse } from 'next';
import prisma from '@/lib/prisma';
import cache from '@/lib/redisCache';
import { cacheKeys, cacheNameSpace } from '@/types/cacheType';

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
                const { query } = req.query; // Get search query from URL params

                // Try to get cached movies first

                // Get all movies with their categories
                const movies = await prisma.movies.findMany({
                    orderBy: { createdAt: 'desc' },
                    take: 10,
                    include: {
                        category: true,
                        sources: true
                    }
                });

                // Transform movies data
                const newMovies = movies.map((movie: any) => ({
                    id: movie.id,
                    categoryId: movie.categoryId,
                    type: movie.type,
                    categoryName: movie.category.name,
                    title: movie.title,
                    description: movie.description || '', // Ensure description exists for search
                    year: movie.year,
                    rating: movie.rating,
                    poster: movie.poster.startsWith('http') ? movie.poster : IMAGE_BASE_URL + '/' + movie.poster,
                    createdAt: movie.createdAt,
                }));

                // Apply search filter if query exists
                const filteredMovies = query
                    ? newMovies.filter(movie =>
                        movie.title.toLowerCase().includes(query.toString().toLowerCase()) ||
                        (movie.description && movie.description.toLowerCase().includes(query.toString().toLowerCase())) ||
                        (movie.categoryName && movie.categoryName.toLowerCase().includes(query.toString().toLowerCase())) ||
                        movie.year.toString().includes(query.toString())
                    )
                    : newMovies;

                return res.status(200).json(filteredMovies);
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