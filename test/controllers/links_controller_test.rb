require 'test_helper'

class LinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @link = links(:fullscreen)
    @update = {
      original_link: "https://fullscreenmedia.com/",
      hash_key: "abc123"
    }
  end

  test "should get index" do
    get links_url
    assert_response :success
  end

  test "should get new" do
    get new_link_url
    assert_response :success
  end

  test "should redirect to original link" do
    get '/' + @link.hash_key
    assert_redirected_to @link.original_link
  end

  test "should create link" do
    assert_difference('Link.count') do
      post links_url, params: { link: @update }
    end

    assert_redirected_to link_url(Link.last)
  end

  test "should show link" do
    get link_url(@link)
    assert_response :success
  end

  test "should get edit" do
    get edit_link_url(@link)
    assert_response :success
  end

  test "should update link" do
    patch link_url(@link), params: { link: @update }
    assert_redirected_to root_path
  end

  test "should destroy link" do
    assert_difference('Link.count', -1) do
      delete link_url(@link)
    end

    assert_redirected_to root_path
  end
end

