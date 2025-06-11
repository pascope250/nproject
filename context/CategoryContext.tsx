'use client'

import { createContext, useContext, useEffect, useState, ReactNode } from "react";
import { Category } from "@/types/category";

interface CategoryContextType {
  categories: Category[];
  loading: boolean;
  error: string | null;
  fetchCategories: () => Promise<void>;
  addCategory: (name: string) => Promise<void>;
  updateCategory: (id: Number, newName: string) => Promise<void>;
  deleteCategory: (id: Number) => Promise<void>;
}

const CategoryContext = createContext<CategoryContextType | undefined>(undefined);

export const useCategoryContext = () => {
  const context = useContext(CategoryContext);
  if (!context) throw new Error("useCategoryContext must be used within a CategoryProvider");
  return context;
};

export function CategoryProvider({ children }: { children: ReactNode }) {
  const [categories, setCategories] = useState<Category[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Fetch all categories
  const fetchCategories = async () => {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch('/api/categories');
      if (!res.ok) throw new Error('Failed to fetch categories');
      const data = await res.json();
      setCategories(data);
    } catch (err: any) {
      setError(err.message || 'Error fetching categories');
    } finally {
      setLoading(false);
    }
  };

  // Add a new category
  const addCategory = async (name: string) => {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch('/api/categories', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ name }),
      });
      if (!res.ok) throw new Error('Failed to add category');
      await fetchCategories();
    } catch (err: any) {
      setError(err.message || 'Error adding category');
    } finally {
      setLoading(false);
    }
  };

  // Update a category
  const updateCategory = async (id: Number, newName: string) => {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch('/api/categories', {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ id, newName }),
      });
      if (!res.ok) throw new Error('Failed to update category');
      await fetchCategories();
    } catch (err: any) {
      setError(err.message || 'Error updating category');
    } finally {
      setLoading(false);
    }
  };

  // Delete a category
  const deleteCategory = async (id: Number) => {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch('/api/categories', {
        method: 'DELETE',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ categoryId: id }),
      });
      
      if (!res.ok) throw new Error('Failed to delete category');
      await fetchCategories();
    } catch (err: any) {
      
      setError(err.message || 'Error deleting category');
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchCategories();
  }, []);

  return (
    <CategoryContext.Provider
      value={{
        categories,
        loading,
        error,
        fetchCategories,
        addCategory,
        updateCategory,
        deleteCategory,
      }}
    >
      {children}
    </CategoryContext.Provider>
  );
}