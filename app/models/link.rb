class Link < ApplicationRecord
  before_validation :add_default_url_protocol
  validates :original_link, presence: true
  # validates :hash_key, uniqueness: { case_sensitive: false }
  after_create :next_key

  URL_REGEXP = /\A((http|https):\/\/)*[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix
  validates :original_link, format: { with: URL_REGEXP, message: 'You provided invalid URL' }

  def add_default_url_protocol
    unless self.original_link[/\Ahttp:\/\//] || self.original_link[/\Ahttps:\/\//]
      self.original_link = "http://#{self.original_link}"
    end
  end

  def next_key
    self.hash_key = short_str(self.original_link, self.id.to_s)
    self.save
  end

  private

  def short_str(url, random_seed)
    chars = ('a'..'z').to_a + ('0'..'9').to_a + ('A'..'Z').to_a
    hex = Digest::MD5.hexdigest(random_seed + random_seed)
    sub_hex_len = hex.length / 8
    short_str = Array.new(4)
    sub_hex_len.times do |i| 
      out_chars = ""
      j = i + 1
      sub_hex = hex[i * 8...j * 8]
      idx = 0x3FFFFFFF & sub_hex.to_i(16)
      6.times {
        index = 0x0000003D & idx
        out_chars += chars[index]
        idx = idx >> 5
      }
      short_str[i] = out_chars
    end
    short_str.sample
  end
end
