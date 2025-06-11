'use client';

import { createContext, useContext, useEffect, useState, ReactNode } from 'react';
import { Comment, Reply } from '@/types/comment';

interface CommentContextType {
  comments: Comment[];
  loading: boolean;
  error: string | null;
  fetchComments: () => Promise<void>;
  deleteComment: (commentId: number) => Promise<void>;
  addComment: (data: Omit<Comment, 'id' | 'createdAt' | 'commentLike' | 'replies'>) => Promise<void>;
  addReply: (commentId: number, data: Omit<Reply, 'id' | 'createdAt' | 'replyLike'>) => Promise<void>;
  likeComment: (commentId: number) => Promise<void>;
  likeReply: (commentId: number, replyId: number) => Promise<void>;
}

const CommentContext = createContext<CommentContextType | undefined>(undefined);

export const useCommentContext = () => {
  const context = useContext(CommentContext);
  if (!context) throw new Error('useCommentContext must be used within a CommentProvider');
  return context;
};

export function CommentProvider({ children }: { children: ReactNode }) {
  const [comments, setComments] = useState<Comment[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Fetch all comments
  const fetchComments = async () => {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch('/api/comments');
      if (!res.ok) throw new Error('Failed to fetch comments');
      const data = await res.json();
      setComments(data);
    } catch (err: any) {
      setError(err.message || 'Error fetching comments');
    } finally {
      setLoading(false);
    }
  };

  // Add a new comment
  const addComment = async (commentData: Omit<Comment, 'id' | 'createdAt' | 'commentLike' | 'replies'>) => {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch('/api/comments', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(commentData),
      });
      if (!res.ok) throw new Error('Failed to add comment');
      await fetchComments();
    } catch (err: any) {
      setError(err.message || 'Error adding comment');
    } finally {
      setLoading(false);
    }
  };

  // Add a reply to a comment
  const addReply = async (commentId: number, replyData: Omit<Reply, 'id' | 'createdAt' | 'replyLike'>) => {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch(`/api/comments/${commentId}/replies`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(replyData),
      });
      if (!res.ok) throw new Error('Failed to add reply');
      await fetchComments();
    } catch (err: any) {
      setError(err.message || 'Error adding reply');
    } finally {
      setLoading(false);
    }
  };

  // Like a comment
  const likeComment = async (commentId: number) => {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch(`/api/comments/${commentId}/like`, {
        method: 'POST',
      });
      if (!res.ok) throw new Error('Failed to like comment');
      await fetchComments();
    } catch (err: any) {
      setError(err.message || 'Error liking comment');
    } finally {
      setLoading(false);
    }
  };

  // Like a reply
  const likeReply = async (commentId: number, replyId: number) => {
    setLoading(true);
    setError(null);
    try {
      const res = await fetch(`/api/comments/${commentId}/replies/${replyId}/like`, {
        method: 'POST',
      });
      if (!res.ok) throw new Error('Failed to like reply');
      await fetchComments();
    } catch (err: any) {
      setError(err.message || 'Error liking reply');
    } finally {
      setLoading(false);
    }
  };

 const deleteComment = async (commentId: number) => {
  setLoading(true);
  setError(null);
  try {
    const res = await fetch(`/api/comments/${commentId}`, {
      method: 'DELETE',
      headers: {
        'Content-Type': 'application/json',
      },
    });

    if (!res.ok) {
      const errorData = await res.json();
      throw new Error(errorData.error || 'Failed to delete comment');
    }

    // Optimistic update - remove the comment from state immediately
    setComments(prev => prev.filter(comment => comment.id !== commentId));
    
  } catch (err: unknown) {
    const message = err instanceof Error ? err.message : 'Error deleting comment';
    setError(message);
    // Refetch comments to ensure state is in sync with server
    await fetchComments();
  } finally {
    setLoading(false);
  }
};

  useEffect(() => {
    fetchComments();
  }, []);

  return (
    <CommentContext.Provider
      value={{
        comments,
        loading,
        error,
        fetchComments,
        deleteComment,
        addComment,
        addReply,
        likeComment,
        likeReply,
      }}
    >
      {children}
    </CommentContext.Provider>
  );
}