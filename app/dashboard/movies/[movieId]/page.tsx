'use client';

import { useParams } from 'next/navigation';
import { useEffect, useMemo, useState } from 'react';
import { useSourceContext } from '@/context/SourceContext';
import { Source } from '@/types/source';
import { DataTable } from '@/components/DataTable/DataTable';
import { Modal } from '@/components/Modal/Modal';
import { SourceForm } from '@/components/SourceForm';
import { Dashboard } from '@/components/Dashboard';

export default function MovieSourcesPage() {
  const params = useParams<{ movieId: string }>();
  const movieId = params?.movieId ?? '';
  const { sources, loading, addSource, updateSource, deleteSource, fetchSources } = useSourceContext();

  const [isModalOpen, setIsModalOpen] = useState(false);
  const [currentSource, setCurrentSource] = useState<Source | null>(null);

  // Filter sources for this movieId
  const filteredSources = useMemo(
    () => sources.filter((src) => String(src.movieId) === String(movieId)),
    [sources, movieId]
  );

  // Optionally, fetch sources on mount (if not handled by context)
  useEffect(() => {
    fetchSources();
  }, [fetchSources]);

  const columns = [
    { accessor: 'name', header: 'Name' },
    { accessor: 'domain', header: 'Domain' },
    { accessor: 'type', header: 'Type' },
    { accessor: 'part', header: 'Part' },
    { accessor: 'baseUrl', header: 'Base URL' },
  ];

  const handleAdd = () => {
    setCurrentSource(null);
    setIsModalOpen(true);
  };

  const handleEdit = (source: Source) => {
    setCurrentSource(source);
    setIsModalOpen(true);
  };

  const handleDelete = async (id: number) => {
    await deleteSource(id);
  };

  const handleSubmit = async (data: Omit<Source, 'id'>) => {
    if (currentSource) {
      await updateSource(currentSource.id, data);
    } else {
      await addSource({ ...data, movieId: Number(movieId) });
    }
    setIsModalOpen(false);
  };

  return (
    <Dashboard>
    <div className="container mx-auto p-4 relative">
      {/* Loading overlay */}
      {loading && (
        <div className="fixed inset-0 bg-black bg-opacity-40 z-50 flex items-center justify-center">
          <svg className="animate-spin h-12 w-12 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
            <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
            <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8z"></path>
          </svg>
        </div>
      )}

      <div className="flex justify-between items-center mb-6">
        <h1 className="text-2xl font-bold">Sources for Movie #{movieId}</h1>
        <button
          onClick={handleAdd}
          className="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded"
        >
          Add Source
        </button>
      </div>

      <DataTable
        data={filteredSources}
        columns={columns}
        onEdit={handleEdit}
        onDelete={handleDelete}
      />

      <Modal
        isOpen={isModalOpen}
        onClose={() => setIsModalOpen(false)}
        title={currentSource ? 'Edit Source' : 'Add Source'}
        size="lg"
        footer={
          <>
            <button
              onClick={() => setIsModalOpen(false)}
              className="px-4 py-2 border border-gray-300 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-50"
            >
              Cancel
            </button>
            <button
              type="submit"
              form="source-form"
              className="px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700"
            >
              {currentSource ? 'Update' : 'Save'}
            </button>
          </>
        }
      >
        <SourceForm
          source={currentSource}
          movieOptions={[]} // Not needed here, since movieId is fixed
          onSubmit={handleSubmit}
        />
      </Modal>
    </div>
    </Dashboard>
  );
}