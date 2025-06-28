// lib/redisCache.ts
import { Redis } from '@upstash/redis'

type CacheOptions = {
  ttl?: number; // Time-to-live in seconds (default: 259200 = 3 day)
}

class UpstashRedisCache {
  private static instance: UpstashRedisCache
  private redis: Redis
  private readonly DEFAULT_TTL = 259200 // 72 hours

  private constructor() {
    this.redis = new Redis({
      url: process.env.UPSTASH_REDIS_REST_URL!,
      token: process.env.UPSTASH_REDIS_REST_TOKEN!,
    })
  }

  public static getInstance(): UpstashRedisCache {
    if (!UpstashRedisCache.instance) {
      UpstashRedisCache.instance = new UpstashRedisCache()
    }
    return UpstashRedisCache.instance
  }

 public async save(
  namespace: string,
  key: string,
  value: any,
  options?: CacheOptions
): Promise<boolean> {
  try {
    const fullKey = `${namespace}:${key}`
    // Ensure we're not double-stringifying
    const serialized = typeof value === 'string' ? value : JSON.stringify(value)
    const ttl = options?.ttl ?? this.DEFAULT_TTL

    await this.redis.set(fullKey, serialized, { ex: ttl })
    return true
  } catch (err) {
    console.error('Cache save error:', err)
    return false
  }
}

public async get<T>(namespace: string, key: string): Promise<T | null> {
  try {
    const fullKey = `${namespace}:${key}`
    const data = await this.redis.get<string>(fullKey)
    
    if (!data) return null
    
    // Handle case where data might already be parsed
    if (typeof data === 'object') {
      return data as T
    }
    
    try {
      return JSON.parse(data)
    } catch (parseError) {
       await this.flush()
      // If parsing fails, return the raw data
      console.warn('Failed to parse cached data, returning raw:', parseError)
      return data as unknown as T
    }
  } catch (err) {
    console.error('Cache get error:', err)
    return null
  }
}

  public async delete(namespace: string, key?: string): Promise<boolean> {
    try {
      if (key) {
        // Delete specific key
        const fullKey = `${namespace}:${key}`
        const deleted = await this.redis.del(fullKey)
        return deleted > 0
      } else {
        // Upstash doesn't support SCAN or KEYS directly — recommend storing an index key list manually if needed
        console.warn('Upstash does not support deleting keys by pattern (namespace:*). Use indexing strategy.')
        return false
      }
    } catch (err) {
      console.error('Cache delete error:', err)
      return false
    }
  }

  public async flush(): Promise<boolean> {
    try {
      await this.redis.flushall()
      return true
    } catch (err) {
      console.error('Cache flush error:', err)
      return false
    }
  }

  public async healthCheck(): Promise<boolean> {
    try {
      const pong = await this.redis.ping()
      return pong === 'PONG'
    } catch (err) {
      return false
    }
  }

  public async disconnect(): Promise<void> {
    // No disconnect needed for Upstash
    return
  }
}

// Singleton instance
const cache = UpstashRedisCache.getInstance()

// Graceful shutdown hooks are unnecessary, but kept for compatibility
process.on('SIGINT', async () => {
  await cache.disconnect()
  process.exit(0)
})

process.on('SIGTERM', async () => {
  await cache.disconnect()
  process.exit(0)
})

export default cache
