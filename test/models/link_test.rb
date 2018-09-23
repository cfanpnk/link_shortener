require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  test "link is not valid without a unique hash key" do
    link = Link.new(original_link: links(:active_link).original_link,
                    hash_key: links(:active_link).hash_key)
    assert link.invalid?
    assert link.errors.messages[:hash_key].any?
  end

  test "create a link with existing but capitalized hash key" do
    link = Link.new(original_link: links(:active_link).original_link,
                    hash_key: links(:active_link).hash_key.upcase)
    assert link.invalid?
    assert link.errors.messages[:hash_key].any?
  end

  test "link is not valid if the URL has no domain name" do
    link = Link.new(original_link: "google", hash_key: "dfy132")
    assert link.invalid?
    assert link.errors.messages[:original_link].any?
  end

  test "link is not valid if the URL has non HTTP protocol" do
    link = Link.new(original_link: "s3://corporate-asset/", hash_key: "efy332")
    assert link.invalid?
    assert link.errors.messages[:original_link].any?
  end

  test "add default protocol to link without protocol" do
    link = Link.new(original_link: "ni.com", hash_key: "fde2d1")
    link.valid?
    assert_equal "http://ni.com", link.original_link
  end
end
