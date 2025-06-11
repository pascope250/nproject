export interface Comment {
  id: number;
  movieId: number;
  userName: string;
  comment: string;
  createdAt: string;
  commentLike: number;
  replies: Reply[];
}

export interface Reply {
  id: number;
  commentId: number;
  userName: string;
  content: string;
  replyLike: number;
  createdAt: string;
}