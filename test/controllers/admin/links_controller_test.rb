require 'test_helper'

class Admin::LinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @active_link = links(:active_link)
    @link = {
      expired: true
    }
  end
  test "should expire a shortened URL" do
    put expire_admin_link_path(@active_link), params: { link: @link }
    assert_redirected_to admin_link_path(@active_link)
  end
end
