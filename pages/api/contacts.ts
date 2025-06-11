import type { NextApiRequest, NextApiResponse } from 'next';
import prisma from '../../lib/prisma';

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  // CORS for local dev
  res.setHeader('Access-Control-Allow-Origin', 'http://localhost:3001');
  res.setHeader('Access-Control-Allow-Methods', 'GET,POST,OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
  res.setHeader('Access-Control-Allow-Credentials', 'true');
  if (req.method === 'OPTIONS') return res.status(200).end();

  try {
    if (req.method === 'POST') {
      const { name, email, subject, message } = req.body;
      if (!name || !email || !subject || !message) {
        return res.status(400).json({ message: 'All fields are required.' });
      }
      const contact = await prisma.contacts.create({
        data: { name, email, subject, message }
      });
      return res.status(201).json(contact);
    }

    if (req.method === 'GET') {
      const contacts = await prisma.contacts.findMany({
        orderBy: { createdAt: 'desc' }
      });
      return res.status(200).json(contacts);
    }

    res.setHeader('Allow', ['GET', 'POST']);
    return res.status(405).json({ message: `Method ${req.method} not allowed` });
  } catch (err) {
    console.error('Contacts API error:', err);
    return res.status(500).json({ message: 'Internal server error' });
  }
}