'use client';

import { useFormik } from 'formik';
import * as Yup from 'yup';
import { useInquiryContext, Inquiry } from '@/context/InquiryContext';
import { Dashboard } from '@/components/Dashboard';
import { DataTable } from '@/components/DataTable/DataTable';
import { Modal } from '@/components/Modal/Modal';
import React from 'react';
import { PlusIcon } from 'lucide-react';

const validationSchema = Yup.object().shape({
  name: Yup.string().required('Name is required'),
  company: Yup.string().required('Company is required'),
  email: Yup.string().email('Invalid email').required('Email is required'),
  phone: Yup.string().required('Phone is required'),
  budget: Yup.string().required('Budget is required'),
  message: Yup.string().required('Message is required'),
});

export default function Inquiries() {
  const { addInquiry, inquiries, loading } = useInquiryContext();
  const [isModalOpen, setIsModalOpen] = React.useState(false);

  const formik = useFormik({
    initialValues: { name: '', company: '', email: '', phone: '', budget: '', message: '' },
    validationSchema,
    onSubmit: async (values, { resetForm }) => {
      await addInquiry(values);
      setIsModalOpen(false);
      resetForm();
    },
  });

  const columns = [
    { accessor: 'name' as keyof Inquiry, header: 'Name' },
    { accessor: 'company' as keyof Inquiry, header: 'Company' },
    { accessor: 'email' as keyof Inquiry, header: 'Email' },
    { accessor: 'phone' as keyof Inquiry, header: 'Phone' },
    { accessor: 'budget' as keyof Inquiry, header: 'Budget' },
    { accessor: 'message' as keyof Inquiry, header: 'Message' },
  ];

  return (
    <Dashboard>
      <div className="container mx-auto p-4">
        <div className="flex justify-between items-center mb-6">
          <h1 className="text-2xl font-bold">Inquiries</h1>
          <button
            onClick={() => setIsModalOpen(true)}
            className="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded flex items-center"
          >
            <PlusIcon className="h-5 w-5 mr-2" />
            Add Inquiry
          </button>
        </div>
        <Modal
          isOpen={isModalOpen}
          onClose={() => setIsModalOpen(false)}
          title="Inquiry Form"
          size="xl"
        >
          <form onSubmit={formik.handleSubmit} className="space-y-4 max-w-lg mx-auto">
            <div>
              <label className="block text-sm font-medium text-gray-700">Name *</label>
              <input
                name="name"
                type="text"
                onChange={formik.handleChange}
                value={formik.values.name}
                className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3"
              />
              {formik.touched.name && formik.errors.name && (
                <p className="text-red-600 text-sm">{formik.errors.name}</p>
              )}
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700">Company *</label>
              <input
                name="company"
                type="text"
                onChange={formik.handleChange}
                value={formik.values.company}
                className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3"
              />
              {formik.touched.company && formik.errors.company && (
                <p className="text-red-600 text-sm">{formik.errors.company}</p>
              )}
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700">Email *</label>
              <input
                name="email"
                type="email"
                onChange={formik.handleChange}
                value={formik.values.email}
                className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3"
              />
              {formik.touched.email && formik.errors.email && (
                <p className="text-red-600 text-sm">{formik.errors.email}</p>
              )}
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700">Phone *</label>
              <input
                name="phone"
                type="text"
                onChange={formik.handleChange}
                value={formik.values.phone}
                className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3"
              />
              {formik.touched.phone && formik.errors.phone && (
                <p className="text-red-600 text-sm">{formik.errors.phone}</p>
              )}
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700">Budget *</label>
              <input
                name="budget"
                type="text"
                onChange={formik.handleChange}
                value={formik.values.budget}
                className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3"
              />
              {formik.touched.budget && formik.errors.budget && (
                <p className="text-red-600 text-sm">{formik.errors.budget}</p>
              )}
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700">Message *</label>
              <textarea
                name="message"
                rows={4}
                onChange={formik.handleChange}
                value={formik.values.message}
                className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3"
              />
              {formik.touched.message && formik.errors.message && (
                <p className="text-red-600 text-sm">{formik.errors.message}</p>
              )}
            </div>
            <button
              type="submit"
              disabled={loading}
              className="w-full bg-blue-600 text-white py-2 rounded hover:bg-blue-700 transition"
            >
              {loading ? 'Sending...' : 'Send Inquiry'}
            </button>
          </form>
        </Modal>
        <DataTable columns={columns} data={inquiries} />
      </div>
    </Dashboard>
  );
}