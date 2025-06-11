import type { NextApiRequest, NextApiResponse } from 'next';
import prisma from '@/lib/prisma';
const INTERFACE_URL = process.env.NEXT_FRONTEND_BASE;
export default async function handler(req: NextApiRequest, res: NextApiResponse) {

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
        const { endpoint, keys, browserId } = req.body;

        if (!endpoint || !keys?.p256dh || !keys?.auth || !browserId) {
            return res.status(400).json({ error: 'Missing subscription data' });
        }

        // Upsert subscription (create if not exists, update if exists)

        // Check if subscription already exists for browserId


        const checkexit = await prisma.subscription.findFirst({
            where: {
                browser_id: browserId,
            },
        });
        if (!checkexit) {
            const subscription = await prisma.subscription.create({
            data: {
                endpoint,
                p256dh_key: keys.p256dh,
                auth_key: keys.auth,
                browser_id: browserId,
                created_at: new Date(),
                updated_at: new Date(),
            },
        });

         return res.status(200).json({ success: true, subscription });
           
        }
    } catch (error) {
        console.error('Subscribe error:', error);
        res.status(500).json({ error: 'Failed to subscribe' });
    }
}