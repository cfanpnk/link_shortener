class Stat < ApplicationRecord
  belongs_to :link
  MAX_CACHE_SIZE = 100

  after_update :clear_cache

  def increment_counter(hash_key)
    redis = Redis.current
    key = redis_counter_key(hash_key)
    current_count = redis.incr(key).to_i
    if current_count >= MAX_CACHE_SIZE
      self.count += current_count
      self.save
      redis.set(key, "0")
    end
  end

  def redis_counter_key(hash_key)
    'link:' + hash_key + ':counter'
  end

  def real_count
    redis_count = Redis.current.get(redis_counter_key(self.link.hash_key)).to_i
    db_count = self.count || 0
    db_count + redis_count
  end

  def self.fetch_link_stat(link)
    Rails.cache.fetch("stat:#{link.id}", expire_in: 1.hour) do
      link.stat
    end
  end

  def clear_cache
    Rails.cache.delete("stat:#{self.link.id}")
  end
end

