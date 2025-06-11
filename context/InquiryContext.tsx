'use client';

import { createContext, useContext, useState, useEffect, ReactNode } from 'react';

export interface Inquiry {
  id: number;
  name: string;
  company: string;
  email: string;
  phone: string;
  budget: string;
  message: string;
  createdAt: string;
}

interface InquiryContextType {
  inquiries: Inquiry[];
  loading: boolean;
  error: string | null;
  fetchInquiries: () => Promise<void>;
  addInquiry: (data: Omit<Inquiry, 'id' | 'createdAt'>) => Promise<void>;
}

const InquiryContext = createContext<InquiryContextType | undefined>(undefined);

export const useInquiryContext = () => {
  const context = useContext(InquiryContext);
  if (!context) throw new Error('useInquiryContext must be used within an InquiryProvider');
  return context;
};

export function InquiryProvider({ children }: { children: ReactNode }) {
  const [inquiries, setInquiries] = useState<Inquiry[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const fetchInquiries = async () => {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch('/api/inquiries');
      if (!res.ok) throw new Error('Failed to fetch inquiries');
      const data = await res.json();
      setInquiries(data);
    } catch (err: any) {
      setError(err.message || 'Error fetching inquiries');
    } finally {
      setLoading(false);
    }
  };

  const addInquiry = async (data: Omit<Inquiry, 'id' | 'createdAt'>) => {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch('/api/inquiries', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data),
      });
      if (!res.ok) throw new Error('Failed to add inquiry');
      await fetchInquiries();
    } catch (err: any) {
      setError(err.message || 'Error adding inquiry');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchInquiries();
  }, []);

  return (
    <InquiryContext.Provider value={{ inquiries, loading, error, fetchInquiries, addInquiry }}>
      {children}
    </InquiryContext.Provider>
  );
}