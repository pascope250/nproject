'use client';

import { useFormik } from 'formik';
import * as Yup from 'yup';
import { Source } from '@/types/source';

interface SourceFormProps {
  source?: Partial<Source> | null;
  movieOptions: { id: number; title: string }[];
  onSubmit: (data: Omit<Source, 'id'>) => void;
}

const validationSchema = Yup.object().shape({
  name: Yup.string().required('Name is required'),
  domain: Yup.string().required('Domain is required'),
  type: Yup.string()
    .oneOf(['END', 'SEASON'], 'Type must be END or SEASON')
    .required('Type is required'),
  part: Yup.number()
    .typeError('Part is required')
    .required('Part is required')
    .min(1, 'Part must be at least 1'),
  baseUrl: Yup.string().required('Base URL is required'),
});

export function SourceForm({ source, movieOptions, onSubmit }: SourceFormProps) {
  const formik = useFormik<Omit<Source, 'id' | 'movieId'>>({
    initialValues: {
      name: source?.name || '',
      domain: source?.domain || '',
      type: source?.type || 'END',
      part: source?.part || 1,
      baseUrl: source?.baseUrl || '',
      downloadLink: source?.downloadLink || '',
      isIframe: source?.isIframe || false,
    },
    validationSchema,
    enableReinitialize: true,
    onSubmit: (values, formikHelpers) => {
      // You must provide a movieId here; adjust as needed for your use case
      const movieId = source?.movieId ?? movieOptions[0]?.id ?? 0;
      onSubmit({ ...values, movieId });
    },
  });

  return (
    <form id="source-form" onSubmit={formik.handleSubmit} className="space-y-4" autoComplete="on">
      <div className='grid grid-cols-2 gap-4'>

      {/* Name input */}
      <div>
        <label htmlFor="name" className="block text-sm font-medium text-gray-700">
          Name *
        </label>
        <input
          id="name"
          name="name"
          type="text"
          value={formik.values.name}
          onChange={formik.handleChange}
          onBlur={formik.handleBlur}
          className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500"
        />
        {formik.touched.name && formik.errors.name && (
          <p className="mt-1 text-sm text-red-600">{formik.errors.name}</p>
        )}
      </div>

      {/* Domain input */}
      <div>
        <label htmlFor="domain" className="block text-sm font-medium text-gray-700">
          Domain *
        </label>
        <input
          id="domain"
          name="domain"
          type="text"
          value={formik.values.domain}
          onChange={formik.handleChange}
          onBlur={formik.handleBlur}
          className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500"
        />
        {formik.touched.domain && formik.errors.domain && (
          <p className="mt-1 text-sm text-red-600">{formik.errors.domain}</p>
        )}
      </div>

      {/* Base URL input */}
      <div>
        <label htmlFor="baseUrl" className="block text-sm font-medium text-gray-700">
          Base URL *
        </label>
        <input
          id="baseUrl"
          name="baseUrl"
          type="text"
          value={formik.values.baseUrl}
          onChange={formik.handleChange}
          onBlur={formik.handleBlur}
          className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500"
        />
        {formik.touched.baseUrl && formik.errors.baseUrl && (
          <p className="mt-1 text-sm text-red-600">{formik.errors.baseUrl}</p>
        )}
      </div>

      {/* Type select */}
      <div>
        <label htmlFor="type" className="block text-sm font-medium text-gray-700">
          Type *
        </label>
        <select
          id="type"
          name="type"
          value={formik.values.type}
          onChange={formik.handleChange}
          onBlur={formik.handleBlur}
          className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500"
        >
          <option value="END">END</option>
          <option value="SEASON">SEASON</option>
        </select>
        {formik.touched.type && formik.errors.type && (
          <p className="mt-1 text-sm text-red-600">{formik.errors.type}</p>
        )}
      </div>

      {/* Part input */}
      <div>
        <label htmlFor="part" className="block text-sm font-medium text-gray-700">
          Part *
        </label>
        <input
          id="part"
          name="part"
          type="number"
          value={formik.values.part}
          onChange={formik.handleChange}
          onBlur={formik.handleBlur}
          min={1}
          className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500"
        />
        {formik.touched.part && formik.errors.part && (
          <p className="mt-1 text-sm text-red-600">{formik.errors.part}</p>
        )}
      </div>

      

      <div>
        <label htmlFor="quality" className="block text-sm font-medium text-gray-700">
          DownloadLink
        </label>
        <input
          id='downloadLink'
          name="downloadLink"
          type="text"
          value={formik.values.downloadLink}
          onChange={formik.handleChange}
          onBlur={formik.handleBlur}
          className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-blue-500 focus:border-blue-500"
        />
        {formik.touched.downloadLink && formik.errors.downloadLink && (
          <p className="mt-1 text-sm text-red-600">{formik.errors.downloadLink}</p>
        )}
      </div>

      <div>
        <label htmlFor="isIframe" className="block text-sm font-medium text-gray-700">
          IsIframe
        </label>
        {/* we will use checkbox */}
        <input
          id="isIframe"
          name="isIframe"
          type="checkbox"
          checked={formik.values.isIframe}
          onChange={formik.handleChange}
          onBlur={formik.handleBlur}
        />
      </div>
      </div>

      <div>
      </div>
    </form>
  );
}