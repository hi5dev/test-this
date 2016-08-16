require 'test_helper'

class Test::ThisTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Test::This::VERSION
  end
end
