import type { NextApiRequest, NextApiResponse } from 'next';
import { authMiddleware } from '@/middleware/adminJwtMiddleware';
import { initializeWebPush, sendPushNotification } from '@/lib/webPush';
import prisma from '@/lib/prisma';
import { NotificationPayload } from '@/types/notification';
import { emitNewNotification } from '@/lib/socket';

// Initialize web push
initializeWebPush();

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }
  try {
    // Apply auth middleware
    await authMiddleware(req, res);

    const { title, message, url } = req.body;

    // Save notification to database
    const notification = await prisma.notification.create({
      data: {
        title,
        message,
        url: url || null,
        is_read: false,
      },
    });

    // Prepare the complete payload
    const notificationPayload: NotificationPayload = {
      id: notification.id,
      title,
      message,
      url: url || '/movies',
      created_at: notification.created_at,
    };

    // Initialize Socket.io if not already done
    // initSocketIO(res);

    // Emit to all connected clients via Socket.io
    emitNewNotification(notificationPayload);

    // Get active subscriptions (last 90 days)
    const ninetyDaysAgo = new Date();
    ninetyDaysAgo.setDate(ninetyDaysAgo.getDate() - 90);

    const subscriptions = await prisma.subscription.findMany(
      {
      where: {
        updated_at: {
          gte: ninetyDaysAgo,
        },
      },
    }
  );

  //   // Send web push notifications
    await Promise.allSettled(
      subscriptions.map((sub: any) =>
        sendPushNotification(sub, notificationPayload)
      )
    );

    res.status(200).json({ success: true });
  } catch (error) {
    console.error('Notification error:', error);
    res.status(500).json({ error: 'Failed to send notifications' });
  }
}