'use client';

import { Dashboard } from "@/components/Dashboard";
import {DataTable} from "@/components/DataTable/DataTable";
import { Modal } from "@/components/Modal/Modal";
import { MovieForm, MovieFormData } from "@/components/MovieForm";
import { PlusIcon } from "lucide-react";
import { useCategoryContext} from '@/context/CategoryContext'
import { Fragment, useState } from "react";
import { Movie } from "@/types/movie";
import { useMovieContext } from "@/context/MovieContext";
import { useRouter } from "next/navigation";
// app/movies/page.tsx
export default function Movies() {
  const router = useRouter();
  const { categories } = useCategoryContext();
  const { addMovie, deleteMovie, fetchMovies, movies, updateMovie, loading} = useMovieContext();
  const newCategories = categories.map((category) => {
    return{
      id: Number(category.id),
      name: category.name,
    }
  });

  console.log(movies);
  
  const newmovies = movies.map((movie) => {
    return{
      id: Number(movie.id),
      title: movie.title,
      categoryId: Number(movie.categoryId),
      poster: movie.poster,
      category: movie.category?.name,
      description: movie.description,
      year: Number(movie.year),
      rating: Number(movie.rating),
      createdAt: movie.createdAt,
    } as Movie;
  });

    const [isModalOpen, setIsModalOpen] = useState(false);
    const [currentMovie, setCurrentMovie] = useState<Movie | null>(null);
  
    const columns = [
      { accessor: "title" as keyof Movie, header: "Title" },
      {
    accessor: 'poster',
    header: 'Poster',
    isImage: true,
    imageOptions: {
      size: "md" as "md",
      rounded: true,
      className: 'border border-gray-200'
    }
  },
      { accessor: "category" as keyof Movie, header: "Category" },
      { accessor: "year" as keyof Movie, header: "Year" },
      { accessor: "rating" as keyof Movie, header: "Rating" },
      { accessor: "createdAt" as keyof Movie, header: "Created At" },
    ];

    const handleSubmit = async(data: MovieFormData) => {
      if(currentMovie){
        try{
          // Ensure poster is string or undefined for updateMovie
          const updateData = {
            ...data,
            poster: typeof data.poster === 'string' ? data.poster : undefined,
          };
          await updateMovie(currentMovie.id, updateData);
          await fetchMovies();
        }catch(error){
          console.log(error);
        }finally{
          setIsModalOpen(false);
        }
    }else{
      try{
        await addMovie(data);
        await fetchMovies();
      }catch(error){
        console.log(error);
      }finally{
        setIsModalOpen(false);
      }
    }
      
    }

    const handleEdit = (movie: Movie) => {
      const modNewMoview = {
        id: movie.id,
        type: movie.type,
        categoryId: movie.categoryId,
        title: movie.title,
        year: movie.year,
        rating: movie.rating,
        description: movie.description,
        poster: movie.poster,
      }
      setCurrentMovie(modNewMoview);
      setIsModalOpen(true);
  }
  const handleAdd = () => {
      setCurrentMovie(null);
      setIsModalOpen(true);
    };

    const handleDelete = async (id: number) => {
      await deleteMovie(id);
    }
const onCustomButtom = (id: number) => {
  router.push(`/dashboard/movies/${id}`)
}
    
  return (
     <Dashboard>
          <div className="container mx-auto p-4">
             {loading && (
          <Fragment>
            <div className="fixed inset-0 bg-black bg-opacity-40 z-50 flex items-center justify-center">
              <svg className="animate-spin h-12 w-12 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
                <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8z"></path>
              </svg>
            </div>
          </Fragment>
        )}
            <div className="flex justify-between items-center mb-6">
              <h1 className="text-2xl font-bold">Movies</h1>
              <button
                onClick={handleAdd}
                className="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded flex items-center"
              >
                <PlusIcon className="h-5 w-5 mr-2" />
                Add movie
              </button>
            </div>
    
            <DataTable
              data={newmovies}
              columns={columns}
              onEdit={handleEdit}
              onDelete={handleDelete}
              onCustomButtom={ onCustomButtom}
              customButtomText="Source"
            />
    
            <Modal
              isOpen={isModalOpen}
              onClose={() => setIsModalOpen(false)}
              title={currentMovie ? "Edit Category" : "Add Category"}
              size="xxl"
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
                    form="movie-form"
                    className="px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700"
                  >
                    {currentMovie ? "Update" : "Save"}
                  </button>
                </>
              }
            >
              <MovieForm movie={currentMovie} categories={newCategories} onSubmit={handleSubmit} />
            </Modal>
          </div>
        </Dashboard>
  );
}