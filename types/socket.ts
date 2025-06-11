import { Server as SocketIOServer } from 'socket.io';
import { Server as HttpServer } from 'http';
import { NextApiResponse } from 'next';

export type NextApiResponseWithSocket = NextApiResponse & {
  socket: {
    server: HttpServer & {
      io?: SocketIOServer;
    };
  };
};