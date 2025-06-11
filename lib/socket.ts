import { Server } from 'socket.io';
import { NotificationPayload } from '@/types/notification';

declare global {
  // Extend the NodeJS global type to include 'io'
  // eslint-disable-next-line no-var
  var io: Server | undefined;
}

export function getIO(): Server {
  if (!global.io) {
    throw new Error('Socket.io not initialized. Make sure server.js is running.');
  }
  return global.io;
}

export function emitNewNotification(
  notification: NotificationPayload,
  room?: string
): void {
  const io = getIO();
  if (room) {
    io.to(room).emit('new-notification', notification);
  } else {
    io.emit('new-notification', notification);
  }
}