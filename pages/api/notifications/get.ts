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
  if (req.method !== 'GET') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    const { browserId } = req.query;

    if (!browserId || typeof browserId !== 'string') {
      return res.status(400).json({ error: 'Browser ID required' });
    }

    // Find the user's subscription
    const subscription = await prisma.subscription.findFirst({
      where: { browser_id: browserId },
    });

    const notifications = await prisma.notification.findMany({
      include: {
        usernotifications: {
          where: subscription ? { subscriptionId: subscription.id } : {},
        },
      },
      orderBy: { created_at: 'desc' },
      take: 20,
    });

    const formattedNotifications = notifications.map((notification: any) => ({
      id: notification.id,
      title: notification.title,
      url: notification.url,
      message: notification.message,
      created_at: notification.created_at,
      isRead: subscription
        ? notification.usernotifications[0]?.is_read || false
        : false,
    }));

    res.json(formattedNotifications);
  } catch (error) {
    console.error('Get notifications error:', error);
    res.status(500).json({ error: 'Failed to fetch notifications' });
  }
}