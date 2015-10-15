require_relative "tz"
require "test/unit"

class TestTZ < Test::Unit::TestCase
  def test_string_conversion
    obj = '1024'.utc
    assert_equal(10, obj.h)
    assert_equal(24, obj.m)
    assert_equal('10:24 UTC', obj.to_s)
  end

  def test_overflow
    obj = '30:70'.utc
    assert_equal(6, obj.h)
    assert_equal(10, obj.m)
  end

  def test_underflow
    obj = TZ.new(-10, -5)
    assert_equal(14, obj.h)
    assert_equal(55, obj.m)
  end
end
