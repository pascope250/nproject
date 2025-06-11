// components/CategoryForm.tsx
'use client';

import { useForm } from 'react-hook-form';

interface CategoryFormProps {
  category?: { name: string; description?: string } | null;
  onSubmit: (data: { name: string; description?: string }) => void;
}

export function CategoryForm({ category, onSubmit }: CategoryFormProps) {
  const {
    register,
    handleSubmit,
    formState: { errors },
    reset,
  } = useForm({
    defaultValues: {
      name: category?.name || '',
      description: category?.description || '',
    },
  });

  return (
    <form
      id="category-form"
      onSubmit={handleSubmit(onSubmit)}
      className="space-y-4"
    >
      <div>
        <label htmlFor="name" className="block text-sm font-medium text-gray-700">
          Name *
        </label>
        <input
          id="name"
          type="text"
          {...register('name', { required: 'Name is required' })}
          className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500"
        />
        {errors.name && (
          <p className="mt-1 text-sm text-red-600">{errors.name.message}</p>
        )}
      </div>

      <div>
        <label htmlFor="description" className="block text-sm font-medium text-gray-700">
          Description
        </label>
        <textarea
          id="description"
          rows={3}
          {...register('description')}
          className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500"
        />
      </div>
    </form>
  );
}