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
  

  if (req.method === 'OPTIONS') return res.status(200).end();

  try {
    if (req.method === 'POST') {
      const { name, company, email, phone, budget, message } = req.body;
      if (!name || !company || !email || !phone || !budget || !message) {
        return res.status(400).json({ message: 'All fields are required.' });
      }
      const inquiry = await prisma.inquiries.create({
        data: { name, company, email, phone, budget, message }
      });
      return res.status(201).json(inquiry);
    }

    if (req.method === 'GET') {
      const inquiries = await prisma.inquiries.findMany({
        orderBy: { createdAt: 'desc' }
      });
      return res.status(200).json(inquiries);
    }

    res.setHeader('Allow', ['GET', 'POST']);
    return res.status(405).json({ message: `Method ${req.method} not allowed` });
  } catch (err) {
    console.error('Inquiries API error:', err);
    return res.status(500).json({ message: 'Internal server error' });
  }
}