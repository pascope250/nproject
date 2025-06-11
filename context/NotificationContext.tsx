'use client';

import React, { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { Notification, Subscription, UserNotification } from '../types/notification';

interface NotificationContextType {
  notifications: Notification[];
  unreadCount: number;
  subscribe: (subscription: PushSubscription, browserId: string) => Promise<void>;
  unsubscribe: () => Promise<void>;
  sendNotification: (title: string, message: string, url?: string) => Promise<void>;
  markAsRead: (notificationId: number) => Promise<void>;
  clearAllNotifications: () => Promise<void>;
  fetchNotifications: (browserId: string) => Promise<void>;
  loading: boolean;
  error: string | null;
}

const NotificationContext = createContext<NotificationContextType | undefined>(undefined);

export const NotificationProvider = ({ children }: { children: ReactNode }) => {
  const [notifications, setNotifications] = useState<Notification[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const unreadCount = notifications.filter(n => !n.is_read).length;

  const fetchNotifications = async () => {
    setLoading(true);
    setError(null);
    try {
      const response = await fetch(`/api/notifications/admin/get`);
      if (!response.ok) {
        throw new Error('Failed to fetch notifications');
      }
      const data = await response.json();
      setNotifications(data);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'An unknown error occurred');
      console.error('Fetch notifications error:', err);
    } finally {
      setLoading(false);
    }
  };

  const subscribe = async (subscription: PushSubscription, browserId: string) => {
    setLoading(true);
    setError(null);
    try {
      const response = await fetch('/api/notifications/subscribe', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          endpoint: subscription.endpoint,
          keys: {
            p256dh: subscription.toJSON().keys?.p256dh,
            auth: subscription.toJSON().keys?.auth,
          },
          browserId,
        }),
      });

      if (!response.ok) {
        throw new Error('Failed to subscribe');
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Subscription failed');
      console.error('Subscribe error:', err);
    } finally {
      setLoading(false);
    }
  };

  const unsubscribe = async () => {
    setLoading(true);
    setError(null);
    try {
      const response = await fetch('/api/notifications/unsubscribe', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('token')}`,
        },
      });

      if (!response.ok) {
        throw new Error('Failed to unsubscribe');
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Unsubscription failed');
      console.error('Unsubscribe error:', err);
    } finally {
      setLoading(false);
    }
  };

  const sendNotification = async (title: string, message: string, url?: string) => {
    setLoading(true);
    setError(null);
    try {
      const response = await fetch('/api/notifications/send', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ title, message, url }),
      });

      if (!response.ok) {
        throw new Error('Failed to send notification');
      }

      // Refresh notifications after sending
      
        await fetchNotifications();
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to send notification');
      console.error('Send notification error:', err);
    } finally {
      setLoading(false);
    }
  };

  const markAsRead = async (notificationId: number) => {
    setLoading(true);
    setError(null);
    try {
      const subscription = JSON.parse(localStorage.getItem('pushSubscription') || '');
      const browserId = localStorage.getItem('browserId');

      if (!browserId) {
        throw new Error('Browser ID not found');
      }

      const response = await fetch(`/api/notifications/${notificationId}/read`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          endpoint: subscription.endpoint,
          keys: subscription.keys,
          browserId,
        }),
      });

      if (!response.ok) {
        throw new Error('Failed to mark as read');
      }

      // Update local state
      setNotifications(prev =>
        prev.map(n =>
          n.id === notificationId ? { ...n, is_read: true } : n
        )
      );
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to mark as read');
      console.error('Mark as read error:', err);
    } finally {
      setLoading(false);
    }
  };

  const clearAllNotifications = async () => {
    setLoading(true);
    setError(null);
    try {
      const response = await fetch('/api/notifications/clear', {
        method: 'POST',
      });

      if (!response.ok) {
        throw new Error('Failed to clear notifications');
      }

     await fetchNotifications();
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to clear notifications');
      console.error('Clear notifications error:', err);
    } finally {
      setLoading(false);
    }
  };

  // Initialize with browserId if available
  useEffect(() => {
      fetchNotifications();
  }, []);

  return (
    <NotificationContext.Provider
      value={{
        notifications,
        unreadCount,
        subscribe,
        unsubscribe,
        sendNotification,
        markAsRead,
        clearAllNotifications,
        fetchNotifications,
        loading,
        error,
      }}
    >
      {children}
    </NotificationContext.Provider>
  );
};

export const useNotifications = () => {
  const context = useContext(NotificationContext);
  if (context === undefined) {
    throw new Error('useNotifications must be used within a NotificationProvider');
  }
  return context;
};