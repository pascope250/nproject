'use client';

import { useFormik } from 'formik';
import * as Yup from 'yup';

export interface MovieFormData {
  categoryId: number;
  title: string;
  year: number;
  rating: number;
  description?: string | null;
  poster?: File | null;
}

interface MovieFormProps {
  movie?: {
    categoryId: number;
    title: string;
    year: number;
    rating: number;
    description?: string | null;
    poster?: string | null;
  } | null;
  categories: { id: number; name: string }[];
  onSubmit: (data: MovieFormData) => void;
}

const validationSchema = Yup.object().shape({
  categoryId: Yup.string().required('Category is required'),
  title: Yup.string().required('Title is required'),
  year: Yup.number()
    .typeError('Year is required')
    .required('Year is required')
    .min(1800, 'Year must be after 1800')
    .max(new Date().getFullYear(), `Year cannot be after ${new Date().getFullYear()}`),
  rating: Yup.number()
    .typeError('Rating is required')
    .required('Rating is required')
    .min(0, 'Rating must be at least 0')
    .max(10, 'Rating cannot be more than 10'),
  description: Yup.string().nullable(),
  poster: Yup.mixed()
    .nullable()
    .test('fileType', 'Please upload a valid image file (jpg, jpeg, png, gif, webp, svg)', (value) => {
      if (!value) return true;
      if (typeof value === 'string') return true;
      if (value instanceof File) {
        return /\.(jpg|jpeg|png|gif|webp|svg)$/i.test(value.name);
      }
      return false;
    }),
});

export function MovieForm({ movie, categories, onSubmit }: MovieFormProps) {
  const formik = useFormik<MovieFormData>({
    initialValues: {
      categoryId: movie ? Number(movie.categoryId) : 0,
      title: movie?.title || '',
      year: movie?.year || 0,
      rating: movie?.rating || 0,
      description: movie?.description ?? '',
      poster: null,
    },
    validationSchema,
    enableReinitialize: true,
    onSubmit: (values) => {
      // If updating and poster is not changed, allow null
      if (!values.poster && movie?.poster) {
        onSubmit({ ...values, poster: null });
      } else {
        onSubmit(values);
      }
    },
  });

  return (
    <form id="movie-form" onSubmit={formik.handleSubmit} className="space-y-4" autoComplete="on">
      {/* Category select */}
      <div>
        <label htmlFor="categoryId" className="block text-sm font-medium text-gray-700">
          Category *
        </label>
        <select
          id="categoryId"
          name="categoryId"
          value={formik.values.categoryId}
          onChange={formik.handleChange}
          onBlur={formik.handleBlur}
          className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500"
        >
          <option value="">Select category</option>
          {categories.map((cat) => (
            <option key={cat.id} value={cat.id}>
              {cat.name}
            </option>
          ))}
        </select>
        {formik.touched.categoryId && formik.errors.categoryId && (
          <p className="mt-1 text-sm text-red-600">{formik.errors.categoryId}</p>
        )}
      </div>

      {/* Title input */}
      <div>
        <label htmlFor="title" className="block text-sm font-medium text-gray-700">
          Title *
        </label>
        <input
          id="title"
          name="title"
          type="text"
          value={formik.values.title}
          onChange={formik.handleChange}
          onBlur={formik.handleBlur}
          className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500"
        />
        {formik.touched.title && formik.errors.title && (
          <p className="mt-1 text-sm text-red-600">{formik.errors.title}</p>
        )}
      </div>

      {/* Year input */}
      <div>
        <label htmlFor="year" className="block text-sm font-medium text-gray-700">
          Year *
        </label>
        <input
          id="year"
          name="year"
          type="number"
          value={formik.values.year}
          onChange={formik.handleChange}
          onBlur={formik.handleBlur}
          className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500"
        />
        {formik.touched.year && formik.errors.year && (
          <p className="mt-1 text-sm text-red-600">{formik.errors.year}</p>
        )}
      </div>

      {/* Rating input */}
      <div>
        <label htmlFor="rating" className="block text-sm font-medium text-gray-700">
          Rating *
        </label>
        <input
          id="rating"
          name="rating"
          type="number"
          step="0.1"
          value={formik.values.rating}
          onChange={formik.handleChange}
          onBlur={formik.handleBlur}
          className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500"
        />
        {formik.touched.rating && formik.errors.rating && (
          <p className="mt-1 text-sm text-red-600">{formik.errors.rating}</p>
        )}
      </div>

      {/* Description textarea */}
      <div>
        <label htmlFor="description" className="block text-sm font-medium text-gray-700">
          Description
        </label>
        <textarea
          id="description"
          name="description"
          rows={3}
          value={formik.values.description ?? ''}
          onChange={formik.handleChange}
          onBlur={formik.handleBlur}
          className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500"
        />
      </div>

      {/* Poster file input */}
      <div>
        <label htmlFor="poster" className="block text-sm font-medium text-gray-700">
          Poster file
        </label>
        <input
          id="poster"
          name="poster"
          type="file"
          accept=".jpg,.jpeg,.png,.gif,.webp,.svg"
          onChange={(e) => {
            formik.setFieldValue('poster', e.currentTarget.files ? e.currentTarget.files[0] : null);
          }}
          onBlur={formik.handleBlur}
          className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500"
        />
        {formik.touched.poster && formik.errors.poster && (
          <p className="mt-1 text-sm text-red-600">{formik.errors.poster}</p>
        )}
      </div>
    </form>
  );
}