module LinksHelper
  def full_url
    request.protocol + request.host + ':' + request.optional_port.to_s + '/'
  end
end
