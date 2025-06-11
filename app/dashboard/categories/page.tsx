// app/categories/page.tsx
"use client";

import { useState } from "react";
import { PlusIcon } from "@heroicons/react/24/outline";
import { DataTable } from "@/components/DataTable/DataTable";
import { Modal } from "@/components/Modal/Modal";
import { CategoryForm } from "@/components/CategoryForm";
import { Dashboard } from "@/components/Dashboard";
import { Category } from "@/types/category";
import { useCategoryContext } from "@/context/CategoryContext";

export default function CategoriesPage() {
  const {
    categories,
    addCategory,
    deleteCategory,
    fetchCategories,
    updateCategory,
  } = useCategoryContext();

  const [isModalOpen, setIsModalOpen] = useState(false);
  const [currentCategory, setCurrentCategory] = useState<Category | null>(null);

  const columns = [
    { accessor: "name" as keyof Category, header: "Name" },
    { accessor: "createdAt" as keyof Category, header: "Created At" },
  ];

  const handleAdd = () => {
    setCurrentCategory(null);
    setIsModalOpen(true);
  };

  const handleEdit = async (category: Category) => {
    // set currrnt category

    setCurrentCategory(category);
    setIsModalOpen(true);
  };

  const handleDelete = async (id: Number) => {
    try {
      await deleteCategory(id);
    } catch (error) {
      console.log(error);
    } finally {
      await fetchCategories();
    }
  };

  const handleSubmit = async (category: Omit<Category, "id" | "createdAt">) => {
    if (currentCategory) {
      try {
        await updateCategory(currentCategory.id, category.name);
      } catch (error) {
        console.log(error);
      } finally {
        await fetchCategories();
        setIsModalOpen(false);
      }
    } else {
      try {
        await addCategory(category.name);
      } catch (error) {
        console.log(error);
      } finally {
        await fetchCategories();
        setIsModalOpen(false);
      }
    }
  };

  // modify createdAt to LocalString

  interface CategoryTableRow {
    id: number;
    name: string;
    createdAt: string;
  }

  const newCategories: CategoryTableRow[] = categories.map((category: Category): CategoryTableRow => {
    return {
      id: category.id,
      name: category.name,
      createdAt: new Date(category.createdAt).toLocaleString(),
    };
  });

  return (
    <Dashboard>
      <div className="container mx-auto p-4">
        <div className="flex justify-between items-center mb-6">
          <h1 className="text-2xl font-bold">Categories</h1>
          <button
            onClick={handleAdd}
            className="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded flex items-center"
          >
            <PlusIcon className="h-5 w-5 mr-2" />
            Add Category
          </button>
        </div>

        <DataTable
          data={newCategories}
          columns={columns}
          onEdit={handleEdit}
          onDelete={handleDelete}
        />

        <Modal
          isOpen={isModalOpen}
          onClose={() => setIsModalOpen(false)}
          title={currentCategory ? "Edit Category" : "Add Category"}
          size="md"
          footer={
            <>
              <button
                onClick={() => setIsModalOpen(false)}
                className="px-4 py-2 border border-gray-300 rounded-md text-sm font-medium text-gray-700 hover:bg-gray-50"
              >
                Cancel
              </button>
              <button
                type="submit"
                form="category-form"
                className="px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700"
              >
                {currentCategory ? "Update" : "Save"}
              </button>
            </>
          }
        >
          <CategoryForm category={currentCategory} onSubmit={handleSubmit} />
        </Modal>
      </div>
    </Dashboard>
  );
}
