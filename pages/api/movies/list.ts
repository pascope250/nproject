import { NextApiRequest, NextApiResponse } from 'next';
import prisma from '@/lib/prisma';
// import radis from '@/lib/redis';

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
        // get all from radis caches

        // const cachedMovies = await radis.get('movies','all');

        // if (typeof cachedMovies === 'string') {
        //   return res.status(200).json(JSON.parse(cachedMovies));
        // }
        // Get all movies with their categories
        const movies = await prisma.movies.findMany({
          orderBy: { createdAt: 'desc' },
          include: {
            category: true,
            sources:true
          }
        });
        // add url on poster from local env

        // movies.forEach((movie: any) => {
        //   if (movie.poster) {
        //     movie.poster = `${process.env.NEXT_PUBLIC_BASE_URL}${movie.poster}`;
        //   }
        // });

        const newMovies = movies.map((movie: any) => {
            return {
      id: movie.id,
      categoryId: movie.categoryId,
      categoryName: movie.category.name,
      title: movie.title,
      year: movie.year,
      rating: movie.rating,
      description: movie.description,
      poster: IMAGE_BASE_URL+'/'+movie.poster,
      createdAt: movie.createdAt,
      source: movie.sources.map((source: any) => {
        return {
          type: source.type,
          part: source.part,
          domain: source.domain,
          baseUrl: source.baseUrl,
          downloadLink: source.downloadLink,
          isIframe: source.isIframe,
        }
      })
    }
        });

        // save to radis cache
        // await radis.save('movies','all',JSON.stringify(newMovies));
        return res.status(200).json(newMovies);
      }

      default:
        res.setHeader('Allow', ['GET', 'POST', 'PUT', 'DELETE']);
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