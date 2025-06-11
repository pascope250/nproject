import { NextApiRequest, NextApiResponse } from 'next';
import prisma from '@/lib/prisma';
import fs from 'fs';
import path from 'path';
import radis from '@/lib/redis';


// Configure where to store uploaded images
const UPLOAD_DIR = path.join(process.cwd(), 'public', 'uploads', 'movies');
const PUBLIC_URL_BASE = '/uploads/posters';

// Ensure upload directory exists
if (!fs.existsSync(UPLOAD_DIR)) {
  fs.mkdirSync(UPLOAD_DIR, { recursive: true });
}

export const config = {
  api: {
    bodyParser: {
      sizeLimit: '10mb' // Increase limit for image uploads
    }
  }
};

const BACKEND_URL = process.env.NEXT_FRONTEND_BASE;
export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {

   // --- CORS for http://localhost:3001 ---
  res.setHeader('Access-Control-Allow-Origin', BACKEND_URL || 'http://localhost:3001');
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

        const cachedMovies = await radis.get('movies','all');

        if (typeof cachedMovies === 'string') {
          return res.status(200).json(JSON.parse(cachedMovies));
        }
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
      poster: PUBLIC_URL_BASE+'/'+movie.poster,
      createdAt: movie.createdAt,
      source: movie.sources.map((source: any) => {
        return {
          type: source.type,
          part: source.part,
          domain: source.domain,
          baseUrl: source.baseUrl,
        }
      })
    }
        });

        // save to radis cache
        await radis.save('movies','all',JSON.stringify(newMovies));
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