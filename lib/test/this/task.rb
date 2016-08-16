namespace :test do
  desc 'Run one test by name'
  task :one, [:path, :test_name] do |t, args|
    # run the test if at least one of the arguments is present
    Test::This.execute(*args) if args.length > 0

    # print the syntax of the task since no arguments were given
    $stderr.puts 'Syntax: rake test:one["PATH","TEST NAME"]'
    $stderr.puts "\nMake sure not to include any spaces between the arguments."
    $stderr.puts 'The name of the test is optional.'

    # exit with status 2
    exit(2)
  end
end
