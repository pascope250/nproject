import { useEffect, useState } from 'react';
import { io, Socket } from 'socket.io-client';
import { NotificationPayload } from '@/types/notification';

export const useSocket = () => {
  const [socket, setSocket] = useState<Socket | null>(null);

  useEffect(() => {
    // Initialize socket connection
    const socketInstance = io({
      path: '/api/socketio',
      transports: ['websocket'],
    });

    setSocket(socketInstance);

    return () => {
      socketInstance.disconnect();
    };
  }, []);

  const listenForNotifications = (
    callback: (notification: NotificationPayload) => void
  ) => {
    if (!socket) return;

    const handler = (notification: NotificationPayload) => {
      callback(notification);
    };

    socket.on('new-notification', handler);

    return () => {
      socket.off('new-notification', handler);
    };
  };

  return {
    socket,
    listenForNotifications,
  };
};