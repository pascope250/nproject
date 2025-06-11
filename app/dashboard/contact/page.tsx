'use client';

import { useFormik } from 'formik';
import * as Yup from 'yup';
import { Contact, useContactContext } from '@/context/ContactContext';
import { Dashboard } from '@/components/Dashboard';
import { DataTable } from '@/components/DataTable/DataTable';
import { Modal } from '@/components/Modal/Modal';
import React from 'react';
import { PlusIcon } from 'lucide-react';

const validationSchema = Yup.object().shape({
  name: Yup.string().required('Name is required'),
  email: Yup.string().email('Invalid email').required('Email is required'),
  subject: Yup.string().required('Subject is required'),
  message: Yup.string().required('Message is required'),
});
export default function Contacts() {
  const { addContact,contacts, loading } = useContactContext();
  const [isModalOpen, setIsModalOpen] = React.useState(false);
  const formik = useFormik({
    initialValues: { name: '', email: '', subject: '', message: '' },
    validationSchema,
    onSubmit: async (values, { resetForm }) => {
      await addContact(values);
      setIsModalOpen(!isModalOpen);
      resetForm();
    },
  });

  const column = [
    {
      accessor: 'name' as keyof Contact, header: 'Name'
    },
    {
      accessor: 'email' as keyof Contact, header: 'Emails'
    },
    {
      accessor: 'subject' as keyof Contact, header: 'Subject'
    },
    {
      accessor: 'message' as keyof Contact, header: 'Message'
    }
  ];

   return (
    <Dashboard>
      <div className="container mx-auto p-4">
        <div className="flex justify-between items-center mb-6">
          <h1 className="text-2xl font-bold">Contacts</h1>
          <button
            onClick={() => setIsModalOpen(true)}
            className="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded flex items-center"
          >
            <PlusIcon className="h-5 w-5 mr-2" />
            Add Contact
          </button>
        </div>
      <Modal
      isOpen={isModalOpen}
      onClose={
        () => setIsModalOpen(false)
      }
      title='Contact form'
      size='xl'
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
        <label className="block text-sm font-medium text-gray-700">Subject *</label>
        <input
          name="subject"
          type="text"
          onChange={formik.handleChange}
          value={formik.values.subject}
          className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3"
        />
        {formik.touched.subject && formik.errors.subject && (
          <p className="text-red-600 text-sm">{formik.errors.subject}</p>
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
        {loading ? 'Sending...' : 'Send Message'}
      </button>
      
    </form>
      </Modal>
    

    <DataTable columns={column}
    data={contacts}></DataTable>
    </div>
    </Dashboard>
  );
}



