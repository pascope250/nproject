// lib/auth.ts
import { serialize } from 'cookie'
import jwt from 'jsonwebtoken'
import bcrypt from 'bcryptjs'
import { NextApiResponse } from 'next'

const SECRET_KEY = process.env.JWT_SECRET || 'your-very-secure-secret-key'
const MAX_AGE = 60 * 60 * 24 * 7 // 1 week

export async function hashPassword(password: string) {
  return await bcrypt.hash(password, 10)
}

export async function verifyPassword(password: string, hashedPassword: string) {
  return await bcrypt.compare(password, hashedPassword)
}

export function generateToken(userId: number) {
  return jwt.sign({ userId }, SECRET_KEY, { expiresIn: MAX_AGE })
}

export function setTokenCookie(res: NextApiResponse, token: string) {
  const cookie = serialize('authToken', token, {
    maxAge: MAX_AGE,
    expires: new Date(Date.now() + MAX_AGE * 1000),
    httpOnly: true,
    secure: process.env.NODE_ENV === 'production',
    path: '/',
    sameSite: 'strict',
  })

  res.setHeader('Set-Cookie', cookie)
}

export function clearTokenCookie(res: NextApiResponse) {
  const cookie = serialize('authToken', '', {
    maxAge: -1,
    path: '/',
  })

  res.setHeader('Set-Cookie', cookie)
}

export function verifyToken(token: string) {
  try {
    return jwt.verify(token, SECRET_KEY) as { userId: number }
  } catch (error) {
    return null
  }
}