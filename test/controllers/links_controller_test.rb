require 'test_helper'

class LinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @active_link = links(:active_link)
    @expired_link = links(:expired_link)
    @link = {
      original_link: "https://www.aa.com",
      hash_key: "djk23s"
    }
  end

  test "should create a shortened URL and redirect to a new page" do
    assert_difference('Link.count') do
      post links_url, params: { link: @link }
    end
    assert_redirected_to link_url(Link.last)
  end

  test "should redirect to the original URL if still active" do
    get '/' + @active_link.hash_key
    assert_redirected_to @active_link.original_link
  end

  test "should render 404 if the link is expired" do
    get '/' + @expired_link.hash_key
    assert_response 404
  end
end

