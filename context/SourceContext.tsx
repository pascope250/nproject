'use client';

import { createContext, useContext, useEffect, useState, ReactNode, useCallback } from 'react';
import { Source } from '@/types/source';

interface SourceContextType {
  sources: Source[];
  loading: boolean;
  error: string | null;
  fetchSources: () => Promise<void>;
  addSource: (data: Omit<Source, 'id'>) => Promise<void>;
  updateSource: (id: number, data: Partial<Omit<Source, 'id'>>) => Promise<void>;
  deleteSource: (id: number) => Promise<void>;
}

const SourceContext = createContext<SourceContextType | undefined>(undefined);

export const useSourceContext = () => {
  const context = useContext(SourceContext);
  if (!context) throw new Error('useSourceContext must be used within a SourceProvider');
  return context;
};

export function SourceProvider({ children }: { children: ReactNode }) {
  const [sources, setSources] = useState<Source[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Fetch all sources (wrapped in useCallback)
  const fetchSources = useCallback(async () => {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch('/api/sources');
      if (!res.ok) throw new Error('Failed to fetch sources');
      const data = await res.json();
      setSources(data);
    } catch (err: any) {
      setError(err.message || 'Error fetching sources');
    } finally {
      setLoading(false);
    }
  }, []); // Empty dependency array means this function is memoized

  // Add a new source
  const addSource = async (sourceData: Omit<Source, 'id'>) => {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch('/api/sources', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(sourceData),
      });
      if (!res.ok) throw new Error('Failed to add source');
      await fetchSources();
    } catch (err: any) {
      setError(err.message || 'Error adding source');
    } finally {
      setLoading(false);
    }
  };

  // Update a source
  const updateSource = async (id: number, updateData: Partial<Omit<Source, 'id'>>) => {
    setLoading(true);
    setError(null);   
    try {
      const res = await fetch('/api/sources', {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ id, EditmovieId: updateData.movieId, Editname: updateData.name, Editdomain: updateData.domain, Edittype: updateData.type, Editpart: updateData.part, EditbaseUrl: updateData.baseUrl }),
      });
      if (!res.ok) throw new Error('Failed to update source');
      await fetchSources();
    } catch (err: any) {
      setError(err.message || 'Error updating source');
    } finally {
      setLoading(false);
    }
  };

  // Delete a source
  const deleteSource = async (id: number) => {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch('/api/sources', {
        method: 'DELETE',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ SourceId: id }),
      });
      if (!res.ok) throw new Error('Failed to delete source');
      await fetchSources();
    } catch (err: any) {
      setError(err.message || 'Error deleting source');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchSources();
  }, [fetchSources]); // Now depends on the memoized fetchSources

  return (
    <SourceContext.Provider
      value={{
        sources,
        loading,
        error,
        fetchSources,
        addSource,
        updateSource,
        deleteSource,
      }}
    >
      {children}
    </SourceContext.Provider>
  );
}