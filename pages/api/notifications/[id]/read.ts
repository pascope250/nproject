import type { NextApiRequest, NextApiResponse } from 'next';
import prisma from '@/lib/prisma';
const INTERFACE_URL = process.env.NEXT_FRONTEND_BASE;
export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {

   // --- CORS for http://localhost:3001 ---
  res.setHeader('Access-Control-Allow-Origin', INTERFACE_URL || 'http://localhost:3000');
  res.setHeader('Access-Control-Allow-Methods', 'GET,POST,PUT,DELETE,OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
  res.setHeader('Access-Control-Allow-Credentials', 'true');

  // Handle preflight OPTIONS request
  if (req.method === 'OPTIONS') {
    return res.status(200).end();
  }
  // --- End CORS ---


  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    const { id: notificationId } = req.query;
    const { endpoint, keys, browserId } = req.body;

    // Find the subscription
    const subscription = await prisma.subscription.findFirst({
      where: {
        // endpoint,
        // p256dh_key: keys.p256dh,
        // auth_key: keys.auth,
        browser_id: browserId,
      },
    });
    if (!subscription) {
      return res.status(404).json({ error: 'Subscription not found' });
    }

    // Check if user notification exists
    const existingUserNotification = await prisma.usernotifications.findFirst({
      where: {
        subscriptionId: subscription.id,
        notificationId: Number(notificationId),
      },
    });

    if (!existingUserNotification) {
      await prisma.usernotifications.create({
        data: {
          subscriptionId: subscription.id,
          notificationId: Number(notificationId),
          is_read: true,
        },
      });
    }

    res.status(200).json({ success: true });
  } catch (error) {
    console.error('Mark as read error:', error);
    res.status(500).json({ error: 'Failed to update notification' });
  }
}