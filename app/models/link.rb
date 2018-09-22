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
    charset = ('a'..'z').to_a + (0..9).to_a
    self.hash_key = (0...6).map{ charset[rand(charset.size)] }.join
    self.save
  end
  
  #   self.hash_key = self.id.to_s(36)
  #   self.save
  # end
end
