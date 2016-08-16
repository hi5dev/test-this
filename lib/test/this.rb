require 'rake'
require 'test/this/task'

module Test
  # @!attribute file_suffix
  # @!attribute test_method_prefix
  # @!attribute test_path
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
