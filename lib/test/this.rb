require 'rake'
require 'test/this/task'

module Test
  # @!attribute file_suffix
  #   Test files are typically suffixed with either `_test.rb` or `_spec.rb`.
  #   This attribute allows you to specify what file suffix your tests use.
  #
  #   @return [String] A file suffix - defaults to "_test.rb".
  #
  # @!attribute test_method_prefix
  #   Minitest methods are prefixed with `test_`. The Rails `test` method
  #   generates tests for Minitest that have the same prefix. This might not
  #   apply to all test suites, so it can be configured when necessary.
  #
  #   @return [String] Prefix for test methods.
  #
  # @!attribute test_path
  #   The full path to the root of the tests. This defaults to using the
  #   current directory that the task was called from.
  #
  #   @return [String] Full path to the tests.
  module This
    autoload :VERSION, 'test/this/version'

    class << self
      attr_accessor :file_suffix, :test_method_prefix, :test_path
    end

    def self.file_suffix
      @file_suffix ||= '_test.rb'
    end

    def self.test_method_prefix
      @test_method_prefix ||= 'test_'
    end

    def self.test_path
      @test_path ||= File.join(Dir.pwd, 'test')
    end

    def self.execute(path, name=nil)
      path = get_test_path(path)

      command = %Q[ruby -I"lib:test" #{path}]
      command << " -n #{get_test_name(name)}" unless name.nil?

      system command
    end

    def self.get_test_path(path)
      File.join(test_path, "#{path}#{file_suffix}")
    end

    def self.get_test_name(name)
      "#{test_method_prefix}#{name.gsub(' ', '_')}"
    end
  end
end
