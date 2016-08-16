require 'test_helper'

class Test::ThisTest < Minitest::Test
  def setup
    @file_suffix = Test::This.file_suffix
    @test_method_prefix = Test::This.test_method_prefix
    @test_path = Test::This.test_path

    Test::This.instance_variable_set(:@file_suffix, nil)
    Test::This.instance_variable_set(:@test_method_prefix, nil)
    Test::This.instance_variable_set(:@test_path, nil)
  end

  def teardown
    Test::This.file_suffix = @file_suffix
    Test::This.test_method_prefix = @test_method_prefix
    Test::This.test_path = @test_path
  end

  def test_that_it_has_a_version_number
    refute_nil ::Test::This::VERSION
  end

  def test_default_file_suffix
    assert_equal '_test.rb', Test::This.file_suffix
  end

  def test_default_test_method_prefix
    assert_equal 'test_', Test::This.test_method_prefix
  end

  def test_default_test_path
    assert_equal File.join(root_path, 'test'), Test::This.test_path
  end

  def test_get_test_path
    Test::This.file_suffix = '_spec.rb'
    expected_path = File.join(root_path, 'test', 'hello', 'world_spec.rb')
    assert_equal expected_path, Test::This.get_test_path('hello/world')
  end

  def test_get_test_name
    assert_equal 'test_this_method', Test::This.get_test_name('this method')
  end

  private

  def root_path
    @root_path ||= File.expand_path('../../', __FILE__)
  end
end
