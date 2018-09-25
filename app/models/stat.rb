class Stat < ApplicationRecord
  MAX_CACHE_SIZE = 100

  def increment_counter(hash_key)
    key = redis_counter_key(hash_key)
    Redis.current.incr(key)
    count = Redis.current.get(key).to_i
    if count >= MAX_CACHE_SIZE
      self.count += count
      self.save
      Redis.current.set(key, "0")
    end
  end

  def redis_counter_key(hash_key)
    'link:' + hash_key + ':counter'
  end
end

