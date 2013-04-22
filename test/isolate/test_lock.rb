require "minitest/autorun"
require "isolate/lock"

module TestIsolate; end

class TestIsolate::TestLock < MiniTest::Unit::TestCase
  def test_sanity
    flunk "write tests or I will kneecap you"
  end
end
