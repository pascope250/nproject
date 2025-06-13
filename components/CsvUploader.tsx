// components/CsvUploader.tsx
import { useState, useCallback } from 'react';
import { uploadSourcesFromCsv } from '../services/api';

export default function CsvUploader() {
  const [file, setFile] = useState<File | null>(null);
  const [isUploading, setIsUploading] = useState(false);
  const [result, setResult] = useState<{message?: string; error?: string}>({});

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files && e.target.files.length > 0) {
      setFile(e.target.files[0]);
    }
  };

  const handleSubmit = useCallback(async (e: React.FormEvent) => {
    e.preventDefault();
    if (!file) return;

    setIsUploading(true);
    setResult({});

    try {
      const response = await uploadSourcesFromCsv(file);
      if (response.error) {
        setResult({ error: response.error });
      } else {
        setResult({ 
          message: response.message || 'Upload successful!'
        });
      }
    } catch (error) {
      setResult({ 
        error: error instanceof Error ? error.message : 'Unknown error occurred'
      });
    } finally {
      setIsUploading(false);
    }
  }, [file]);

  return (
    <div className="max-w-md mx-auto p-6 bg-white rounded-lg shadow-md">
      <h2 className="text-xl font-semibold mb-4">Upload CSV to Database</h2>
      <form onSubmit={handleSubmit} className="space-y-4">
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">
            CSV File
          </label>
          <input
            type="file"
            accept=".csv"
            onChange={handleFileChange}
            className="block w-full text-sm text-gray-500
              file:mr-4 file:py-2 file:px-4
              file:rounded-md file:border-0
              file:text-sm file:font-semibold
              file:bg-blue-50 file:text-blue-700
              hover:file:bg-blue-100"
            disabled={isUploading}
            required
          />
        </div>
        
        <button
          type="submit"
          disabled={!file || isUploading}
          className={`w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white ${
            !file || isUploading
              ? 'bg-gray-400 cursor-not-allowed'
              : 'bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500'
          }`}
        >
          {isUploading ? 'Uploading...' : 'Upload CSV'}
        </button>
      </form>

      {result.message && (
        <div className="mt-4 p-3 bg-green-50 text-green-700 rounded-md">
          {result.message}
        </div>
      )}
      
      {result.error && (
        <div className="mt-4 p-3 bg-red-50 text-red-700 rounded-md">
          {result.error}
        </div>
      )}
    </div>
  );
}