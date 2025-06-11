'use client';

import { createContext, useContext, useState, useEffect, ReactNode } from 'react';

export interface Contact {
  id: number;
  name: string;
  email: string;
  subject: string;
  message: string;
  createdAt: string;
}

interface ContactContextType {
  contacts: Contact[];
  loading: boolean;
  error: string | null;
  fetchContacts: () => Promise<void>;
  addContact: (data: Omit<Contact, 'id' | 'createdAt'>) => Promise<void>;
}

const ContactContext = createContext<ContactContextType | undefined>(undefined);

export const useContactContext = () => {
  const context = useContext(ContactContext);
  if (!context) throw new Error('useContactContext must be used within a ContactProvider');
  return context;
};

export function ContactProvider({ children }: { children: ReactNode }) {
  const [contacts, setContacts] = useState<Contact[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const fetchContacts = async () => {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch('/api/contacts');
      if (!res.ok) throw new Error('Failed to fetch contacts');
      const data = await res.json();
      setContacts(data);
    } catch (err: any) {
      setError(err.message || 'Error fetching contacts');
    } finally {
      setLoading(false);
    }
  };

  const addContact = async (data: Omit<Contact, 'id' | 'createdAt'>) => {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch('/api/contacts', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data),
      });
      if (!res.ok) throw new Error('Failed to add contact');
      await fetchContacts();
    } catch (err: any) {
      setError(err.message || 'Error adding contact');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchContacts();
  }, []);

  return (
    <ContactContext.Provider value={{ contacts, loading, error, fetchContacts, addContact }}>
      {children}
    </ContactContext.Provider>
  );
}