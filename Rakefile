require 'bundler/gem_tasks'
require 'rake/testtask'
require 'test/this'

Test::This.tap do |config|
  config.file_suffix = '_test.rb'
  config.test_method_prefix = 'test_'
  config.test_path = File.join(Dir.pwd, 'test')
end

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

task default: :test
