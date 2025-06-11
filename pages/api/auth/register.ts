// pages/api/auth/register.ts
import prisma from '../../../lib/prisma'
import { hashPassword } from '../../../lib/auth'
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
    const existingUser = await prisma.users.findUnique({
      where: { email }
    })

    if (existingUser) {
      return res.status(400).json({ message: 'Email already in use' })
    }

    const hashedPassword = await hashPassword(password)
    
    const user = await prisma.users.create({
      data: {
        email,
        password: hashedPassword
      }
    })

    res.status(201).json({ 
      id: user.id,
      email: user.email,
      createdAt: user.createdAt
    })
  } catch (error) {
    console.error(error)
    res.status(500).json({ message: 'Registration failed' })
  }
}