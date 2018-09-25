module ApplicationHelper
  def display_url_of(hash_key)
    # display_link_url(:hash_key => link.hash_key)
    "#{request.scheme}://#{request.host}:#{request.port}/#{hash_key}"
  end
end
