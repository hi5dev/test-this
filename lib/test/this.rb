require 'rake'
require 'test/this/task'

module Test
  # @!attribute file_suffix
  # @!attribute minitest_method_prefix
  # @!attribute suite
  # @!attribute test_path
  module This
    autoload :VERSION, 'test/this/version'

    class << self
      attr_accessor :file_suffix, :minitest_method_prefix, :test_path
    end

    def self.file_suffix
      @file_suffix ||= '_test.rb'
    end

    def self.minitest_method_prefix
      @minitest_method_prefix ||= 'test_'
    end

    def self.suite
      @suite ||= :rails
    end

    def self.suite=(value)
      return @suite = value if [:rails, :minitest].include?(value)

      fail ArgumentError, "unknown test suite: #{value}"
    end

    def self.test_path
      @test_path ||= File.join(Dir.pwd, 'test')
    end

    def self.execute(path, name=nil)
      path = get_test_path(path)
      name = get_test_name(name)

      command = %Q[ruby -I"lib:test" #{path}]
      command << " -n #{name}" unless name.nil?

      system command
    end

    def self.get_test_path(path)
      File.join(test_path, "#{path}#{file_suffix}")
    end

    def self.get_test_name(name)
      return if "#{name}".empty?

      case suite
      when :rails then name
      when :minitest then "#{minitest_method_prefix}#{name.gsub(' ', '_')}"
      else fail
      end
    end
  end
end
