require 'test_helper'

class Test::ThisTest < Minitest::Test
  def setup
    @file_suffix = Test::This.file_suffix
    @minitest_method_prefix = Test::This.minitest_method_prefix
    @suite = Test::This.suite
    @test_path = Test::This.test_path

    Test::This.instance_variable_set(:@file_suffix, nil)
    Test::This.instance_variable_set(:@minitest_method_prefix, nil)
    Test::This.instance_variable_set(:@suite, nil)
    Test::This.instance_variable_set(:@test_path, nil)
  end

  def teardown
    Test::This.file_suffix = @file_suffix
    Test::This.minitest_method_prefix = @minitest_method_prefix
    Test::This.suite = @suite
    Test::This.test_path = @test_path
  end

  def test_that_it_has_a_version_number
    refute_nil ::Test::This::VERSION
  end

  def test_default_file_suffix
    assert_equal '_test.rb', Test::This.file_suffix
  end

  def test_default_minitest_method_prefix
    assert_equal 'test_', Test::This.minitest_method_prefix
  end

  def test_default_suite
    assert_equal :rails, Test::This.suite
  end

  def test_default_test_path
    test_path = File.expand_path('../../../test', __FILE__)

    assert_equal test_path, Test::This.test_path
  end

  def test_suite_cannot_be_invalid_value
    assert_raises(ArgumentError) { Test::This.suite = :unknown_suite }
  end
end
