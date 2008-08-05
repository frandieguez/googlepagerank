require "test/unit"

require "googlepagerank"

class TestGooglePageRank < Test::Unit::TestCase
  def test_valid_domain
    assert_equal(9, GooglePageRank.get("www.apple.com",80,nil,nil))
  end
  def test_invalid_domain
    assert_equal(-1, GooglePageRank.get("w.w.w.com",80))
  end
  def test_malformed_domain
    assert_equal(-1, GooglePageRank.get("@@@",80))
  end
end