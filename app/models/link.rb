class Link < ApplicationRecord
  has_one :stat
  before_create :generate_next_key, :set_slug
  before_validation :add_default_url_protocol
  validates :hash_key, uniqueness: { case_sensitive: false }

  URL_REGEXP = /\A((http|https):\/\/)*[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix
  validates :original_link, format: { with: URL_REGEXP, message: 'You provided invalid URL' }

  after_update :clear_cache

  def add_default_url_protocol
    unless self.original_link[/\Ahttp:\/\//] || self.original_link[/\Ahttps:\/\//]
      self.original_link = "http://#{self.original_link}"
    end
  end

  def generate_next_key
    loop do
      self.hash_key = generate_key(self.original_link)
      break unless Link.where(hash_key: hash_key).exists?
    end
  end

  def to_param
    slug
  end

  def clear_cache
    Rails.cache.delete(self.class.redis_url_key(hash_key))
  end

  def self.redis_url_key(hash_key)
    'link:' + hash_key + ':url'
  end

  def self.fetch_link!(hash_key)
    Rails.cache.fetch(redis_url_key(hash_key), expire_in: 1.day) do
      Link.find_by!(hash_key: hash_key)
    end
  end

  private

  def generate_key(long_url)
    chars = ('a'..'z').to_a + ('0'..'9').to_a + ('A'..'Z').to_a
    random_seed = Time.now.to_s

    # MD5 Hash the long_url into a 32 character string
    hex = Digest::MD5.hexdigest(long_url + random_seed)

    # Divide the hash into 4 parts
    sub_hex_len = hex.length / 8
    short_str = Array.new(4)

    # Interate thru the 4 parts
    sub_hex_len.times do |i| 
      out_chars = ""
      j = i + 1
      sub_hex = hex[i * 8...j * 8]
      # Bit and operation between 0x3FFFFFFF(30) and the base-16 string
      # Ignore the chars beyond 30
      idx = 0x3FFFFFFF & sub_hex.to_i(16)
      # 30 chars are divided into 6 parts
      6.times {
        index = 0x0000003D & idx
        out_chars += chars[index]
        idx = idx >> 5
      }
      # Get 4 keys
      short_str[i] = out_chars
    end
    short_str.sample
  end

  def set_slug
    loop do
      self.slug = SecureRandom.uuid
      break unless Link.where(slug: slug).exists?
    end
  end
end
