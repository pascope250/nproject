import { NextApiRequest, NextApiResponse } from 'next';
import prisma from '../../lib/prisma';
// import redis from '@/lib/redis';
import fs from 'fs';
import path from 'path';
import { v4 as uuidv4 } from 'uuid';

// Configure where to store uploaded images
const UPLOAD_DIR = path.join(process.cwd(), 'public', 'posters');
const PUBLIC_URL_BASE = '/posters';

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
      case 'POST': {
        // Destructure and validate required fields
        const { title, categoryId, year, rating, description, poster } = req.body;
        
        if (!title || !categoryId || !year || !rating || !description || !poster) {
          return res.status(400).json({ 
            message: 'All fields are required: title, categoryId, year, rating, description, and poster',
          });
        }

        // Handle image upload
        let posterUrl = '';
        if (poster) {
          try {
            // Example for base64 image - adjust based on your frontend implementation
            if (poster.startsWith('data:image')) {
              const base64Data = poster.replace(/^data:image\/\w+;base64,/, '');
              const buffer = Buffer.from(base64Data, 'base64');
              const fileName = `poster-${uuidv4()}.jpg`;
              const filePath = path.join(UPLOAD_DIR, fileName);
              
              await fs.promises.writeFile(filePath, buffer);
              posterUrl = `${fileName}`;
            } else if (poster.startsWith('http')) {
              // If it's already a URL (from CDN), use as-is
              posterUrl = poster;
            }
          } catch (uploadError) {
            console.error('Image upload failed:', uploadError);
            return res.status(400).json({
              message: 'Failed to process image upload',
            });
          }
        }
        // Create new movie
         await prisma.movies.create({
          data: { 
            title, 
            categoryId: Number(categoryId),
            year: Number(year),
            rating: parseFloat(rating),
            description,
            poster: posterUrl,
            // createdAt is automatic via Prisma @default(now())
          },
          include: {
            category: true // Include related category data
          }
        });
        // await redis.delete('movies','all');
        return res.status(201).json({ 
          message: 'Movie created successfully',
        });
      }

      case 'GET': {
        // Get all movies with their categories
        const movies = await prisma.movies.findMany({
          orderBy: { createdAt: 'desc' },
          include: {
            category: true
          }
        });
        // add url on poster from local env

        movies.forEach((movie: any) => {
          if (movie.poster) {
            movie.poster = `${PUBLIC_URL_BASE}/${movie.poster}`;
            movie.createdAt = movie.createdAt.toISOString();
          }
        });
        
        return res.status(200).json(movies);
      }
      case 'PUT': {
        // Update movie
        const { id, title, categoryId, year, rating, description, poster } = req.body;

        if (!id || !title || !categoryId || !year || !rating || !description) {
          return res.status(400).json({ 
            message: 'All fields are required',
          });
        }

        // Handle poster update if provided
        let updateData: any = {
          title,
          categoryId: Number(categoryId),
          year: Number(year),
          rating: parseFloat(rating),
          description
        };

        if (poster) {
          if (poster.startsWith('data:image')) {
            // Handle new image upload (same as POST)
            const base64Data = poster.replace(/^data:image\/\w+;base64,/, '');
            const buffer = Buffer.from(base64Data, 'base64');
            const fileName = `poster-${uuidv4()}.jpg`;
            const filePath = path.join(UPLOAD_DIR, fileName);
            
            await fs.promises.writeFile(filePath, buffer);
            updateData.poster = `${fileName}`;
          } else if (poster.startsWith('http')) {
            updateData.poster = poster;
          }
        }

        const updatedMovie = await prisma.movies.update({
          where: { id: Number(id) },
          data: updateData,
          include: {
            category: true
          }
        });
        // await redis.delete('movies','all');

        return res.status(200).json(updatedMovie);
      }

      case 'DELETE': {
        // Delete movie - typically should use query params for DELETE
        const { id } = req.query;

        if (!id || Array.isArray(id)) {
          return res.status(400).json({
            message: 'Valid movie ID is required in query parameters',
          });
        }

        // First get the movie to delete its poster file
        const movieToDelete = await prisma.movies.findUnique({
          where: { id: Number(id) }
        });

        if (!movieToDelete) {
          return res.status(404).json({
            message: 'Movie not found',
          });
        }

        // Delete the poster file if it exists and is locally stored
        if (movieToDelete.poster && movieToDelete.poster.startsWith(PUBLIC_URL_BASE)) {
          const fileName = movieToDelete.poster.split('/').pop();
          const filePath = path.join(UPLOAD_DIR, fileName!);
          try {
            await fs.promises.unlink(filePath);
          } catch (err) {
            console.error('Failed to delete poster file:', err);
          }
        }

        await prisma.movies.delete({
          where: { id: Number(id) },
        });

        // await redis.delete('movies','all');

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