import { NextApiRequest, NextApiResponse } from 'next';
import prisma from '../../lib/prisma';
import cache from '@/lib/redisCache';
import { v4 as uuidv4 } from 'uuid';
import { cacheKeys, cacheNameSpace } from '@/types/cacheType';
import { v2 as cloudinary } from 'cloudinary';
const PUBLIC_URL_BASE = '/posters';
// Configure Cloudinary
cloudinary.config({ 
  cloud_name: process.env.CLOUDINARY_CLOUD_NAME, 
  api_key: process.env.CLOUDINARY_API_KEY, 
  api_secret: process.env.CLOUDINARY_API_SECRET 
});

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
  'http://localhost:3001',
].filter(Boolean);

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
  
  if (req.method === 'OPTIONS') {
    return res.status(200).end();
  }
  // --- End CORS ---

  try {
    switch (req.method) {
      case 'POST': {
        const { title, categoryId,type, year, rating, description, poster } = req.body;
        
        if (!title || !categoryId || !year || !rating || !description || !poster) {
          return res.status(400).json({ 
            message: 'All fields are required: title, categoryId, year, rating, description, and poster',
          });
        }

        let posterUrl = '';
        if (poster) {
          try {
            if (poster.startsWith('data:image')) {
              const uploadResponse = await cloudinary.uploader.upload(poster, {
                folder: 'movie-posters',
                public_id: `poster-${uuidv4()}`,
                overwrite: false,
                transformation: [
                  { width: 500, height: 750, crop: 'fill' },
                  { quality: 'auto:best' }
                ]
              });
              posterUrl = uploadResponse.secure_url;
            } else if (poster.startsWith('http')) {
              posterUrl = poster;
            }
          } catch (uploadError) {
            console.error('Cloudinary upload failed:', uploadError);
            return res.status(400).json({
              message: 'Failed to process image upload',
            });
          }
        }

        const newMovie = await prisma.movies.create({
          data: { 
            title, 
            type,
            categoryId: Number(categoryId),
            year: Number(year),
            rating: parseFloat(rating),
            description,
            poster: posterUrl,
          },
          include: {
            category: true
          }
        });
        
        await cache.delete(cacheNameSpace.movie, cacheKeys.movie); 
        await cache.delete(cacheNameSpace.original, cacheKeys.original); 
        return res.status(201).json(newMovie);
      }

      case 'GET': {
        const movies = await prisma.movies.findMany({
          orderBy: { createdAt: 'desc' },
          include: {
            category: true
          }
        });

        // Convert dates to ISO strings for JSON serialization
        const formattedMovies = movies.map(movie => ({
          ...movie,
          createdAt: movie.createdAt.toISOString(),
          // if not from cloudinary means not include cloudinary, just return the url
          poster: movie.poster.startsWith('http') ? movie.poster : `${PUBLIC_URL_BASE}/${movie.poster}`
        }));


        return res.status(200).json(formattedMovies);
      }

      case 'PUT': {
        const { id, title, categoryId,type, year, rating, description, poster } = req.body;

        if (!id || !title || !categoryId || !year || !rating || !description) {
          return res.status(400).json({ 
            message: 'All fields are required',
          });
        }

        let updateData: any = {
          title,
          type,
          categoryId: Number(categoryId),
          year: Number(year),
          rating: parseFloat(rating),
          description
        };

        if (poster) {
          try {
            if (poster.startsWith('data:image')) {
              // Upload new image to Cloudinary
              const uploadResponse = await cloudinary.uploader.upload(poster, {
                folder: 'movie-posters',
                public_id: `poster-${uuidv4()}`,
                transformation: [
                  { width: 500, height: 750, crop: 'fill' },
                  { quality: 'auto:best' }
                ]
              });
              updateData.poster = uploadResponse.secure_url;

              // Delete old image from Cloudinary if it exists
              const oldMovie = await prisma.movies.findUnique({
                where: { id: Number(id) }
              });
              if (oldMovie?.poster) {
                const publicId = oldMovie.poster.split('/').pop()?.split('.')[0];
                if (publicId) {
                  await cloudinary.uploader.destroy(publicId).catch(console.error);
                }
              }
            } else if (poster.startsWith('http')) {
              updateData.poster = poster;
            }
          } catch (uploadError) {
            console.error('Cloudinary upload failed:', uploadError);
            return res.status(400).json({
              message: 'Failed to process image upload',
            });
          }
        }

        const updatedMovie = await prisma.movies.update({
          where: { id: Number(id) },
          data: updateData,
          include: {
            category: true
          }
        });
      
        await cache.delete(cacheNameSpace.movie, cacheKeys.movie);
        await cache.delete(cacheNameSpace.original, cacheKeys.original);
        return res.status(200).json(updatedMovie);
      }

      case 'DELETE': {
        const { id } = req.query;

        if (!id || Array.isArray(id)) {
          return res.status(400).json({
            message: 'Valid movie ID is required in query parameters',
          });
        }

        const movieToDelete = await prisma.movies.findUnique({
          where: { id: Number(id) }
        });

        if (!movieToDelete) {
          return res.status(404).json({
            message: 'Movie not found',
          });
        }

        // Delete the poster from Cloudinary if it exists
        if (movieToDelete.poster) {
          try {
            const publicId = movieToDelete.poster.split('/').pop()?.split('.')[0];
            if (publicId) {
              await cloudinary.uploader.destroy(publicId);
            }
          } catch (err) {
            console.error('Failed to delete poster from Cloudinary:', err);
          }
        }

        await prisma.movies.delete({
          where: { id: Number(id) },
        });

        await cache.delete(cacheNameSpace.movie, cacheKeys.movie);
        await cache.delete(cacheNameSpace.original, cacheKeys.original);
        return res.status(204).end();
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