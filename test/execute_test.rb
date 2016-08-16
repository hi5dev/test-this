require 'test_helper'

class ExecuteTest < Minitest::Test
  # Mocks Test::This#system so it captures the command that would have been
  # executed instead of actually exeucting it. The command is stored in
  # Test::This#captured_command so it can be tested.
  #
  # This needs to be a Proc, because modules are not allowed inside methods.
  @@mock_system = Proc.new do
    module Test::This
      class << self
        alias_method :real_system, :system

        attr_reader :captured_command

        def capture_command(*args)
          @captured_command = args
        end

        alias_method :system, :capture_command
      end
    end
  end

  # Removes the mocked Test::This#system and restores the real system method.
  @@restore_system = Proc.new do
    module Test::This
      class << self
        alias_method :system, :real_system

        remove_method :capture_command
        remove_method :real_system
      end
    end
  end

  def setup
    @@mock_system.call
  end

  def teardown
    @@restore_system.call
  end

  def test_execute_with_name
    path = File.join(root_path, 'test', 'execute_test.rb')
    expected_command = %Q[ruby -I"lib:test" #{path} -n test_this_method]

    Rake::Task['test:this'].execute(path: 'execute', test_name: 'this method')

    assert_equal 1, Test::This.captured_command.length
    assert_equal expected_command, Test::This.captured_command[0]
  end

  def test_execute_without_name
    path = File.join(root_path, 'test', 'execute_test.rb')
    expected_command = %Q[ruby -I"lib:test" #{path}]

    Rake::Task['test:this'].execute(path: 'execute')

    assert_equal 1, Test::This.captured_command.length
    assert_equal expected_command, Test::This.captured_command[0]
  end

  private

  def root_path
    @root_path ||= File.expand_path('../../', __FILE__)
  end
end
