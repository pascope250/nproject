import { NextApiRequest, NextApiResponse } from 'next';
import { verifyToken } from '@/lib/auth'
export const authMiddleware = async (
  req: NextApiRequest,
  res: NextApiResponse
) => {
  const token = req.cookies.authToken
  
    if (!token) {
      return res.status(401).json({ message: 'Not authenticated' })
    }
  
    const decoded = verifyToken(token)
  
    if (!decoded) {
      return res.status(401).json({ message: 'Invalid token' })
    }
  
    if (req.method === 'GET' || req.method === 'POST' || req.method === 'PUT' || req.method === 'DELETE') {
      res.status(200).json({ 
        message: 'This is protected data',
        userId: decoded.userId
      })
    } else {
      res.status(405).json({ message: 'Method not allowed' })
    }
};