require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  test "link is not valid without a unique hash key" do
    link = Link.new(original_link: links(:fullscreen).original_link,
                    hash_key: links(:fullscreen).hash_key)
    assert link.invalid?
    assert link.errors.messages[:hash_key].any?
  end

  test "create a link with existing but capitalized hash key" do
    link = Link.new(original_link: links(:fullscreen).original_link,
                    hash_key: links(:fullscreen).hash_key.upcase)
    assert link.invalid?
    assert link.errors.messages[:hash_key].any?
  end

  test "link is not valid with an invalid URL" do
    link = Link.new(original_link: links(:invalid_url).original_link,
                    hash_key: links(:invalid_url).hash_key)
    assert link.invalid?
    assert link.errors.messages[:original_link].any?            
  end

  test "add default protocol to link without protocol" do
    link = Link.new(original_link: links(:no_protocol_url).original_link,
                    hash_key: links(:no_protocol_url).hash_key)
    link.valid?
    assert_equal "http://ni.com", link.original_link
  end
end
