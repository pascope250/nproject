import type { NextApiRequest, NextApiResponse } from 'next';
import prisma from '@/lib/prisma';
const ALLOWED_ORIGINS = [
  process.env.NEXT_FRONTEND_BASE,
  'https://npfrontend-opp7.vercel.app',
  'https://hobbyvb.com',
  'http://localhost:3001', // Add more domains as needed
].filter(Boolean); // Remove undefined values

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
 // --- Dynamic CORS Handling ---
  const origin = req.headers.origin;
  if (origin && ALLOWED_ORIGINS.includes(origin)) {
    res.setHeader('Access-Control-Allow-Origin', origin);
  }
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