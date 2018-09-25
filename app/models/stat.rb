class Stat < ApplicationRecord
  MAX_CACHE_SIZE = 100

  def increment_counter(hash_key)
    redis = Redis.current
    key = redis_counter_key(hash_key)
    current_count = redis.incr(key).to_i
    if current_count >= MAX_CACHE_SIZE
      self.count += count
      self.save
      redis.set(key, "0")
    end
  end

  def redis_counter_key(hash_key)
    'link:' + hash_key + ':counter'
  end
end

