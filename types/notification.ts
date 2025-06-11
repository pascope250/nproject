export interface Notification {
  id: number;
  title: string;
  message: string;
  url: string | null;
  is_read: boolean;
  created_at: string;
}

export interface Subscription {
  id: number;
  endpoint: string;
  p256dh_key: string;
  auth_key: string;
  browser_id: string;
  created_at: Date;
  updated_at: Date;
}

export interface UserNotification {
  id: number;
  subscriptionId: number;
  notificationId: number;
  is_read: boolean;
  created_at: Date;
  updated_at: Date;
}

export interface NotificationPayload {
  id: number;
  title: string;
  message: string;
  url: string;
  created_at: Date;
}