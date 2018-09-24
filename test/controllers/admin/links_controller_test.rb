require 'test_helper'

class Admin::LinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @active_link = links(:active_link)
    @link = {
      expired: true
    }
  end
  test "should expire a shortened URL" do
    patch admin_link_url(@active_link), params: { link: @link }
    assert_redirected_to root_path
  end
end
