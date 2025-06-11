// pages/api/auth/session.ts
import prisma from '../../../lib/prisma'
import { verifyToken } from '../../../lib/auth'
import { NextApiRequest, NextApiResponse } from 'next'

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  if (req.method !== 'GET') {
    return res.status(405).json({ message: 'Method not allowed' })
  }

  const token = req.cookies.authToken

  if (!token) {
    return res.status(401).json({ message: 'Not authenticated' })
  }

  const decoded = verifyToken(token)

  if (!decoded) {
    return res.status(401).json({ message: 'Invalid token' })
  }

  try {
    const user = await prisma.users.findUnique({
      where: { id: decoded.userId },
      select: {
        id: true,
        email: true,
        createdAt: true
      }
    })

    if (!user) {
      return res.status(404).json({ message: 'User not found' })
    }

    res.status(200).json(user)
  } catch (error) {
    console.error(error)
    res.status(500).json({ message: 'Failed to fetch session' })
  }
}