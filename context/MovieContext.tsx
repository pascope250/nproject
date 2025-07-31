'use client';

import { MovieFormData } from '@/components/MovieForm';
import { createContext, useContext, useEffect, useState, ReactNode } from 'react';

interface Movie {
  id: number;
  categoryId: number;
  type: string;
  title: string;
  year: number;
  rating: number;
  description?: string | null;
  poster?: string;
  createdAt?: string;
  category?: { id: number; name: string };
}

interface MovieContextType {
  movies: Movie[];
  loading: boolean;
  error: string | null;
  fetchMovies: () => Promise<void>;
  addMovie: (data: Omit<MovieFormData, 'id' | 'createdAt' | 'category'>) => Promise<void>;
  updateMovie: (id: number, data: Partial<Omit<Movie, 'id' | 'createdAt' | 'category'>>) => Promise<void>;
  deleteMovie: (id: number) => Promise<void>;
}

const MovieContext = createContext<MovieContextType | undefined>(undefined);

export const useMovieContext = () => {
  const context = useContext(MovieContext);
  if (!context) throw new Error('useMovieContext must be used within a MovieProvider');
  return context;
};

export function MovieProvider({ children }: { children: ReactNode }) {
  const [movies, setMovies] = useState<Movie[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Fetch all movies
  const fetchMovies = async () => {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch('/api/movies');
      if (!res.ok) throw new Error('Failed to fetch movies');
      const data = await res.json();
      setMovies(data);
    } catch (err: any) {
      setError(err.message || 'Error fetching movies');
    } finally {
      setLoading(false);
    }
  };

  // Add a new movie
  const addMovie = async (data: Omit<MovieFormData, 'id' | 'createdAt' | 'category'>) => {
    setLoading(true);
    setError(null);
    try {
      let posterUrl: string | undefined = undefined;
      if (data.poster instanceof File) {
        // Convert file to base64 string or upload and get URL
        posterUrl = await new Promise<string>((resolve, reject) => {
          const reader = new FileReader();
          reader.onload = () => resolve(reader.result as string);
          reader.onerror = reject;
          if (data.poster) {
            reader.readAsDataURL(data.poster);
          } else {
            resolve('');
          }
        });
      } else if (typeof data.poster === 'string') {
        posterUrl = data.poster;
      }
      const movieData = {
        ...data,
        poster: posterUrl,
      };
      const res = await fetch('/api/movies', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(movieData),
      });
      if (!res.ok) throw new Error('Failed to add movie');
      await fetchMovies();
    } catch (err: any) {
      setError(err.message || 'Error adding movie');
    } finally {
      setLoading(false);
    }
  };

  // Update a movie
  const updateMovie = async (id: number, updateData: Partial<Omit<Movie, 'id' | 'createdAt' | 'category'>>) => {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch('/api/movies', {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ id, ...updateData }),
      });
      if (!res.ok) throw new Error('Failed to update movie');
      await fetchMovies();
    } catch (err: any) {
      setError(err.message || 'Error updating movie');
    } finally {
      setLoading(false);
    }
  };

  // Delete a movie
  const deleteMovie = async (id: number) => {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch(`/api/movies?id=${id}`, {
        method: 'DELETE',
      });
      if (!res.ok) throw new Error('Failed to delete movie');
      await fetchMovies();
    } catch (err: any) {
      setError(err.message || 'Error deleting movie');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchMovies();
  }, []);

  return (
    <MovieContext.Provider
      value={{
        movies,
        loading,
        error,
        fetchMovies,
        addMovie,
        updateMovie,
        deleteMovie,
      }}
    >
      {children}
    </MovieContext.Provider>
  );
}