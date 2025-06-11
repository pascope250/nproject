'use client';

import { useState, useMemo } from 'react';

interface ColumnDef<TData> {
  accessor: keyof TData | string;
  header: string;
  cellRenderer?: (item: TData) => React.ReactNode;
  isImage?: boolean;
  imageOptions?: {
    className?: string;
    size?: 'sm' | 'md' | 'lg';
    rounded?: boolean;
  };
}

interface DataTableProps<TData> {
  data: TData[];
  columns: ColumnDef<TData>[];
  onEdit?: (item: TData) => void;
  onDelete?: (id: number) => void;
  // onCustomButtom with get JSX
  onCustomButtom?: (id: number) => void;
  customButtomText?: string;
  showActions?: boolean;
  pageSize?: number;
}

export function DataTable<TData>({
  data,
  columns,
  onEdit,
  onDelete,
  onCustomButtom,
  customButtomText,
  showActions = true,
  pageSize = 10,
}: DataTableProps<TData>) {
  // State for sorting
  const [sortBy, setSortBy] = useState<string | null>(null);
  const [sortDirection, setSortDirection] = useState<'asc' | 'desc'>('asc');
  
  // State for pagination
  const [currentPage, setCurrentPage] = useState(1);
  
  // State for search
  const [searchTerm, setSearchTerm] = useState('');

  // Handle sort click
  const handleSort = (accessor: string) => {
    if (sortBy === accessor) {
      setSortDirection(sortDirection === 'asc' ? 'desc' : 'asc');
    } else {
      setSortBy(accessor);
      setSortDirection('asc');
    }
    setCurrentPage(1);
  };

  // Filter data based on search term
  const filteredData = useMemo(() => {
    if (!searchTerm) return data;
    
    return data.filter(item => 
      columns.some(column => {
        const value = item[column.accessor as keyof TData];
        return String(value).toLowerCase().includes(searchTerm.toLowerCase());
      })
    );
  }, [data, searchTerm, columns]);

  // Sort data
  const sortedData = useMemo(() => {
    return [...filteredData].sort((a, b) => {
      if (!sortBy) return 0;
      
      const aValue = a[sortBy as keyof TData];
      const bValue = b[sortBy as keyof TData];
      
      if (aValue === bValue) return 0;
      if (aValue == null) return 1;
      if (bValue == null) return -1;
      
      if (typeof aValue === 'number' && typeof bValue === 'number') {
        return sortDirection === 'asc' 
          ? Number(aValue) - Number(bValue) 
          : Number(bValue) - Number(aValue);
      }
      
      return sortDirection === 'asc'
        ? String(aValue).localeCompare(String(bValue))
        : String(bValue).localeCompare(String(aValue));
    });
  }, [filteredData, sortBy, sortDirection]);

  // Pagination logic
  const totalItems = sortedData.length;
  const totalPages = Math.ceil(totalItems / pageSize);
  const paginatedData = useMemo(() => {
    const startIndex = (currentPage - 1) * pageSize;
    return sortedData.slice(startIndex, startIndex + pageSize);
  }, [sortedData, currentPage, pageSize]);

  // Handle page change
  const goToPage = (page: number) => {
    if (page >= 1 && page <= totalPages) {
      setCurrentPage(page);
    }
  };

  // Default image renderer
  const renderImageCell = (item: TData, accessor: string, options?: ColumnDef<TData>['imageOptions']) => {
    const sizeClasses = {
      sm: 'h-8 w-8',
      md: 'h-10 w-10',
      lg: 'h-12 w-12'
    };
    
    const roundedClass = options?.rounded ? 'rounded-full' : 'rounded-md';
    const sizeClass = sizeClasses[options?.size || 'md'];
    
    return (
      <img 
        src={String(item[accessor as keyof TData]) || '/placeholder.png'}
        alt=""
        className={`object-cover ${sizeClass} ${roundedClass} ${options?.className || ''}`}
        onError={(e) => {
          (e.target as HTMLImageElement).src = '/placeholder.png';
        }}
      />
    );
  };

  return (
    <div className="space-y-4">
      {/* Search Input */}
      <div className="relative max-w-xs">
        <input
          type="text"
          placeholder="Search..."
          className="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-md leading-5 bg-white placeholder-gray-500 focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm"
          value={searchTerm}
          onChange={(e) => {
            setSearchTerm(e.target.value);
            setCurrentPage(1);
          }}
        />
        <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
          <svg className="h-5 w-5 text-gray-400" fill="currentColor" viewBox="0 0 20 20">
            <path fillRule="evenodd" d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z" clipRule="evenodd" />
          </svg>
        </div>
      </div>

      {/* Table */}
      <div className="overflow-x-auto bg-white rounded-lg shadow">
        <table className="min-w-full divide-y divide-gray-200">
          <thead className="bg-gray-50">
            <tr>
              {columns.map((column) => (
                <th
                  key={column.accessor as string}
                  className={`px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider ${
                    column.isImage ? 'w-24' : ''
                  } ${column.accessor !== 'actions' ? 'cursor-pointer select-none' : ''}`}
                  onClick={() => column.accessor !== 'actions' ? handleSort(column.accessor as string) : null}
                >
                  <div className="flex items-center">
                    {column.header}
                    {sortBy === column.accessor && (
                      <span className="ml-1">
                        {sortDirection === 'asc' ? '▲' : '▼'}
                      </span>
                    )}
                  </div>
                </th>
              ))}
              {showActions && (onEdit || onDelete) && (
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider w-32">
                  Actions
                </th>
              )}
            </tr>
          </thead>
          <tbody className="bg-white divide-y divide-gray-200">
            {paginatedData.length > 0 ? (
              paginatedData.map((item, index) => (
                <tr key={index} className="hover:bg-gray-50">
                  {columns.map((column) => (
                    <td
                      key={column.accessor as string}
                      className={`px-6 py-4 whitespace-nowrap ${
                        column.isImage ? '' : 'text-sm text-gray-900'
                      }`}
                    >
                      {column.cellRenderer 
                        ? column.cellRenderer(item)
                        : column.isImage
                          ? renderImageCell(item, column.accessor as string, column.imageOptions)
                          : String(item[column.accessor as keyof TData])
                      }
                    </td>
                  ))}
                  {showActions && (onEdit || onDelete) && (
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500 flex space-x-2">
                      {onEdit && (
                        <button
                          onClick={() => onEdit(item)}
                          className="text-blue-600 hover:text-blue-900 cursor-pointer"
                        >
                          Edit
                        </button>
                      )}
                      {onDelete && (
                        <button
                          onClick={() => onDelete((item as any).id)}
                          className="text-red-600 hover:text-red-900 cursor-pointer"
                        >
                          Delete
                        </button>
                      )}
                      {
                        onCustomButtom && (
                          <button
                            onClick={() => onCustomButtom((item as any).id)}
                            className="text-green-600 hover:text-green-900 cursor-pointer"
                          >
                            {customButtomText}
                          </button>
                        )
                      }
                    </td>
                  )}
                </tr>
              ))
            ) : (
              <tr>
                <td 
                  colSpan={columns.length + (showActions ? 1 : 0)} 
                  className="px-6 py-4 text-center text-sm text-gray-500"
                >
                  No records found
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>

      {/* Pagination Controls */}
      {totalPages > 1 && (
        <div className="flex items-center justify-between px-4 py-3 bg-white border-t border-gray-200 sm:px-6">
          <div className="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between">
            <div>
              <p className="text-sm text-gray-700">
                Showing <span className="font-medium">{(currentPage - 1) * pageSize + 1}</span> to{' '}
                <span className="font-medium">
                  {Math.min(currentPage * pageSize, totalItems)}
                </span>{' '}
                of <span className="font-medium">{totalItems}</span> results
              </p>
            </div>
            <div>
              <nav className="relative z-0 inline-flex rounded-md shadow-sm -space-x-px" aria-label="Pagination">
                <button
                  onClick={() => goToPage(currentPage - 1)}
                  disabled={currentPage === 1}
                  className="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed"
                >
                  <span className="sr-only">Previous</span>
                  <svg className="h-5 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                    <path fillRule="evenodd" d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" clipRule="evenodd" />
                  </svg>
                </button>

                {Array.from({ length: Math.min(5, totalPages) }, (_, i) => {
                  let pageNum;
                  if (totalPages <= 5) {
                    pageNum = i + 1;
                  } else if (currentPage <= 3) {
                    pageNum = i + 1;
                  } else if (currentPage >= totalPages - 2) {
                    pageNum = totalPages - 4 + i;
                  } else {
                    pageNum = currentPage - 2 + i;
                  }

                  return (
                    <button
                      key={pageNum}
                      onClick={() => goToPage(pageNum)}
                      className={`relative inline-flex items-center px-4 py-2 border text-sm font-medium ${
                        currentPage === pageNum
                          ? 'z-10 bg-blue-50 border-blue-500 text-blue-600'
                          : 'bg-white border-gray-300 text-gray-500 hover:bg-gray-50'
                      }`}
                    >
                      {pageNum}
                    </button>
                  );
                })}

                <button
                  onClick={() => goToPage(currentPage + 1)}
                  disabled={currentPage === totalPages}
                  className="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed"
                >
                  <span className="sr-only">Next</span>
                  <svg className="h-5 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                    <path fillRule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clipRule="evenodd" />
                  </svg>
                </button>
              </nav>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}