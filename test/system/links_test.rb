require "application_system_test_case"

class LinksTest < ApplicationSystemTestCase
  test "creating a new shortened URL" do
    visit root_path
    fill_in "Paste a URL to shorten it", with: "roosterteeth.com"
    click_on "Create Link"
    assert_text "Shortened URL"
  end

  test "creating with a invalid URL" do
    visit root_path
    fill_in "Paste a URL to shorten it", with: "google"
    click_on "Create Link"
    assert_text "Invalid URL. Please try again."
  end

  test "expiring a shortened URL" do
    visit root_path
    fill_in "Paste a URL to shorten it", with: "roosterteeth.com"
    click_on "Create Link"
    find('a.admin').click
    click_on "Expire"
    assert_text "The shortened URL has been expired"
  end

  test "visiting a shortened URL" do
    visit root_path
    fill_in "Paste a URL to shorten it", with: "roosterteeth.com"
    click_on "Create Link"
    find('a.admin').click
    find('a.short').click
    sleep 1
    page.evaluate_script('window.location.reload()')
    assert_text "Clicks: 1"
  end
end
