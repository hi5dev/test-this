require 'test_helper'

class TestThis < Minitest::Test
  def test_this_one
    $this_one = true
  end

  def test_not_this_one
    $not_this_one = true
  end
end
