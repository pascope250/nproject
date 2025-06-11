import { createClient } from 'redis';

type CacheOptions = {
  ttl?: number; // Time-to-live in seconds (default: 86400 = 1 day)
};

class RedisCache {
  private client: ReturnType<typeof createClient>;
  private static instance: RedisCache;
  private readonly DEFAULT_TTL = 86400; // 24 hours in seconds

  private constructor() {
    this.client = createClient({
      url: process.env.NEXT_REDIS_URL || 'redis://localhost:6379'
    });
    this.setupEventListeners();
  }

  public static getInstance(): RedisCache {
    if (!RedisCache.instance) {
      RedisCache.instance = new RedisCache();
    }
    return RedisCache.instance;
  }

  private setupEventListeners() {
    this.client.on('error', (err) => console.error('Redis error:', err));
    this.client.on('connect', () => console.log('Redis connected'));
    this.client.on('ready', () => console.log('Redis ready'));
    this.client.on('reconnecting', () => console.log('Redis reconnecting'));
  }

  public async connect(): Promise<void> {
    if (!this.client.isOpen) {
      await this.client.connect();
    }
  }

  // Simplified CRUD operations with default TTL
  public async save(
    namespace: string,
    key: string,
    value: any,
    options?: CacheOptions
  ): Promise<boolean> {
    try {
      await this.connect();
      const fullKey = `${namespace}:${key}`;
      const serialized = JSON.stringify(value);
      const ttl = options?.ttl ?? this.DEFAULT_TTL;

      await this.client.setEx(fullKey, ttl, serialized);
      return true;
    } catch (err) {
      console.error('Cache save error:', err);
      return false;
    }
  }

  public async get<T>(namespace: string, key: string): Promise<T | null> {
    try {
      await this.connect();
      const fullKey = `${namespace}:${key}`;
      const data = await this.client.get(fullKey);
      return data ? JSON.parse(data) : null;
    } catch (err) {
      console.error('Cache get error:', err);
      return null;
    }
  }

  public async delete(namespace: string, key?: string): Promise<boolean> {
    try {
      await this.connect();
      
      if (key) {
        // Delete specific key
        const fullKey = `${namespace}:${key}`;
        return (await this.client.del(fullKey)) > 0;
      } else {
        // Delete all keys in namespace
        const keys = await this.client.keys(`${namespace}:*`);
        if (keys.length === 0) return false;
        return (await this.client.del(keys)) > 0;
      }
    } catch (err) {
      console.error('Cache delete error:', err);
      return false;
    }
  }

  public async flush(): Promise<boolean> {
    try {
      await this.connect();
      await this.client.flushAll();
      return true;
    } catch (err) {
      console.error('Cache flush error:', err);
      return false;
    }
  }

  public async healthCheck(): Promise<boolean> {
    try {
      await this.connect();
      return await this.client.ping() === 'PONG';
    } catch (err) {
      return false;
    }
  }

  public async disconnect(): Promise<void> {
    if (this.client.isOpen) {
      await this.client.quit();
    }
  }
}

// Singleton instance with graceful shutdown
const cache = RedisCache.getInstance();

process.on('SIGINT', async () => {
  await cache.disconnect();
  process.exit(0);
});

process.on('SIGTERM', async () => {
  await cache.disconnect();
  process.exit(0);
});

export default cache;