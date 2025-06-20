// app/categories/page.tsx
"use client";
import { format } from "date-fns";
import { useState } from "react";
import { Modal } from "@/components/Modal/Modal";
import { Dashboard } from "@/components/Dashboard";
import { Comment } from "@/types/comment";
import { useCommentContext } from "@/context/commentContext";
export default function CategoriesPage() {
  const {
    addComment,
    addReply,
    error,
    comments,
    deleteComment,
    loading,
    fetchComments,
    likeReply,
    likeComment,
  } = useCommentContext();
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [currentComment, setCurrentComment] = useState<number | null>(null);
  const [userName, setUserName] = useState("");
  const [comment, setComment] = useState("");
  const handleReply = (comment_id: number) => {
    setCurrentComment(comment_id);
    setIsModalOpen(true);
  };

  const handleDeleteComment = async (id: number) => {
    try {
      await deleteComment(id);
      fetchComments();
    } catch (err) {
      console.log(err);
    }
  };

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    try {
      await addComment({
        comment,
        userName,
        movieId: 5,
      });

      setUserName("");
      setComment("");
    } catch (err) {
      console.log(err);
    }
  };

  const handleLike = async (comment_id: number) => {
    try {
      await likeComment(comment_id);
    } catch (err) {
      console.log(err);
    }
  };

  const handleSubmitReply = async (e: React.FormEvent<HTMLFormElement>) => {
  e.preventDefault();
  try {
    if (!currentComment) return; // Ensure we have a comment ID
    const commentId = currentComment;
    await addReply(commentId, {
      commentId: commentId,
      content: comment,
      userName: userName
    });
    
    setComment("");
    setUserName(""); // Clear both fields if needed
    setIsModalOpen(false);
    await fetchComments(); // Refresh the list
  } catch (err) {
    console.error("Error adding reply:", err);
  }
};

  const handleReplyLike = async (comment_id: number, reply_id: number) => {
    try {
      await likeReply(comment_id, reply_id);
    } catch (err) {
      console.log(err);
    }
  };

  return (
    <Dashboard>
      <div className="container mx-auto p-4">
        <div className="flex justify-between items-center mb-6">
          <h1 className="text-2xl font-bold">Comments</h1>
          {/* <button
            onClick={handleAdd}
            className="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded flex items-center"
          >
            <PlusIcon className="h-5 w-5 mr-2" />
            Add Category
          </button> */}
        </div>
        <form
          onSubmit={handleSubmit}
          className="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4"
        >
          <h2 className="text-xl font-bold mb-4">Add a Comment</h2>

          {error && (
            <div className="mb-4 p-2 bg-red-100 text-red-700 rounded">
              {error}
            </div>
          )}

          <div className="mb-4">
            <label
              className="block text-gray-700 text-sm font-bold mb-2"
              htmlFor="author"
            >
              Name
            </label>
            <input
              className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
              id="userName"
              name="userName"
              type="text"
              placeholder="Your name"
              required
              value={userName}
              onChange={(e) => setUserName(e.target.value)}
            />
          </div>

          <div className="mb-4">
            <label
              className="block text-gray-700 text-sm font-bold mb-2"
              htmlFor="content"
            >
              Comment
            </label>
            <textarea
              className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
              id="content"
              name="comments"
              rows={3}
              placeholder="Your comment"
              required
              value={comment}
              onChange={(e) => setComment(e.target.value)}
            />
          </div>

          <div className="flex items-center justify-between">
            <button
              className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline cursor-pointer"
              type="submit"
              disabled={loading}
            >
              {loading ? "Posting..." : "Post Comment"}
            </button>
          </div>
        </form>
        <div className="bg-white shadow-md rounded px-8 pt-6 pb-8">
          <h2 className="text-xl font-bold mb-4">Comments</h2>

          {comments.length > 0 ? (
            <ul>
              {comments.map((comment) => (
                <li key={comment.id} className="mb-4 border-b pb-2">
                  <div className="flex items-center mb-1">
                    <span className="font-semibold text-gray-800">
                      {comment.userName+ `(${comment.movieId})`}
                    </span>
                    <span className="ml-2 text-xs text-gray-500">
                      {format(
                        new Date(comment.createdAt),
                        "MMM d, yyyy h:mm a"
                      )}
                    </span>
                  </div>

                  <p className="text-gray-700">{comment.comment}</p>

                  <div className="flex items-center space-x-4 mt-2">
                    <button
                      onClick={() => handleLike(comment.id)}
                      className="flex items-center text-pink-500 hover:text-pink-700 text-sm font-semibold focus:outline-none cursor-pointer"
                    >
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        className="h-5 w-5 mr-1"
                        fill="currentColor"
                        viewBox="0 0 20 20"
                      >
                        <path d="M3.172 5.172a4 4 0 015.656 0L10 6.343l1.172-1.171a4 4 0 115.656 5.656L10 17.657l-6.828-6.829a4 4 0 010-5.656z" />
                      </svg>
                      Like
                      {comment.commentLike > 0 && ` (${comment.commentLike})`}
                    </button>

                    <a
                      href="#"
                      onClick={() => handleReply(comment.id)}
                      className="text-blue-500 hover:underline text-sm"
                    >
                      Reply
                    </a>

                    {/* {add delete button here} */}
                    <a
                      href="#"
                      onClick={() => handleDeleteComment(comment.id)}
                      className="flex items-center text-green-500 hover:text-pink-700 text-sm font-semibold focus:outline-none cursor-pointer"
                    >
                      Delete
                    </a>
                  </div>

                  {comment.replies && comment.replies.length > 0 && (
                    <ul className="ml-6 mt-3 border-l-2 border-blue-100 pl-4">
                      {comment.replies.map((reply) => (
                        <li key={reply.id} className="mb-2">
                          <div className="flex items-center mb-1">
                            <span className="font-semibold text-gray-700">
                              {reply.userName}
                            </span>
                            <span className="ml-2 text-xs text-gray-400">
                              {format(
                                new Date(reply.createdAt),
                                "MMM d, yyyy h:mm a"
                              )}
                            </span>
                          </div>

                          <p className="text-gray-600">{reply.content}</p>

                          <button
                            onClick={() =>
                              handleReplyLike(reply.commentId, reply.id)
                            }
                            className="flex items-center text-pink-400 hover:text-pink-600 text-xs font-semibold focus:outline-none mt-1"
                          >
                            <svg
                              xmlns="http://www.w3.org/2000/svg"
                              className="h-4 w-4 mr-1"
                              fill="currentColor"
                              viewBox="0 0 20 20"
                            >
                              <path d="M3.172 5.172a4 4 0 015.656 0L10 6.343l1.172-1.171a4 4 0 115.656 5.656L10 17.657l-6.828-6.829a4 4 0 010-5.656z" />
                            </svg>
                            Like{reply.replyLike > 0 && ` (${reply.replyLike})`}
                          </button>
                        </li>
                      ))}
                    </ul>
                  )}
                </li>
              ))}
            </ul>
          ) : (
            <p className="text-gray-500">
              No comments yet. Be the first to comment!
            </p>
          )}
        </div>
      </div>

      <Modal
        isOpen={isModalOpen}
        onClose={() => setIsModalOpen(false)}
        title="Add Reply"
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
              Reply
            </button>
          </>
        }
      >
        <form id="category-form" 
        onSubmit={handleSubmitReply}
        >
          <div className="mb-4">
            <label htmlFor="comment" className="block text-gray-700 font-bold mb-2">
              Username
            </label>
            <input
              type="text"
              id="userName"
              value={userName}
              onChange={(e) => setUserName(e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:border-blue-500"
              required
            />
          </div>
          <div className="mb-4">
            <label htmlFor="comment" className="block text-gray-700 font-bold mb-2">
              Comment
            </label>
            <textarea
              id="comment"
              value={comment}
              onChange={(e) => setComment(e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:border-blue-500"
              required
            />
          </div>
        </form>
      </Modal>
    </Dashboard>
  );
}
