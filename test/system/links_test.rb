require "application_system_test_case"

class LinksTest < ApplicationSystemTestCase
  test "creating a new shortened URL" do
    visit root_path
    fill_in "Paste a URL to shorten it", with: "roosterteeth.com"
    click_on "Create Link"
    assert_text "Shortened URL"
  end
end
