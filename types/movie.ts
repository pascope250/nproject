export interface Movie {
    id: number;
    categoryId: number;
    categoryName?: string;
    title: string;
    year: number;
    rating: number;
    description?: string;
    poster?: string;
    createdAt?: string;
    category?: { id: number; name: string };
}