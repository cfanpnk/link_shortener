class Link < ApplicationRecord
  before_validation :add_default_url_protocol
  validates :original_link, :hash_key, presence: true
  validates :hash_key, uniqueness: { case_sensitive: false }

  URL_REGEXP = /\A((http|https):\/\/)*[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix
  validates :original_link, format: { with: URL_REGEXP, message: 'You provided invalid URL' }

  def add_default_url_protocol
    unless self.original_link[/\Ahttp:\/\//] || self.original_link[/\Ahttps:\/\//]
      self.original_link = "http://#{self.original_link}"
    end
  end
end
