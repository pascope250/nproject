// pages/api/auth/login.ts
import prisma from '../../../lib/prisma'
import { verifyPassword, generateToken, setTokenCookie } from '../../../lib/auth'
import { NextApiRequest, NextApiResponse } from 'next'

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  if (req.method !== 'POST') {
    return res.status(405).json({ message: 'Method not allowed' })
  }

  const { email, password } = req.body

  if (!email || !password) {
    return res.status(400).json({ message: 'Email and password are required' })
  }

  try {
    const user = await prisma.users.findUnique({
      where: { email }
    })

    if (!user) {
      return res.status(401).json({ message: 'Invalid credentials' })
    }

    const isValid = await verifyPassword(password, user.password)

    if (!isValid) {
      return res.status(401).json({ message: 'Invalid credentials' })
    }

    const token = generateToken(user.id)
    setTokenCookie(res, token)

    res.status(200).json({ 
      id: user.id,
      email: user.email,
      // createdAt: user.createdAt
    })
  } catch (error) {
    console.error(error)
    res.status(500).json({ message: 'Login failed' })
  }
}