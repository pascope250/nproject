import { Server as SocketIOServer } from 'socket.io';
import { Server as HttpServer } from 'http';
import { NextApiResponse } from 'next';

/**
 * Extends NextApiResponse to include Socket.IO server instance
 * without modifying global types
 */
export type NextApiResponseWithSocket = NextApiResponse & {
  socket: NextApiResponse['socket'] & {
    server: HttpServer & {
      io?: SocketIOServer;
    };
  };
};