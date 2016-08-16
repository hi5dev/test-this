# Test::This

Often I want to run just one test in a class full of other tests. I usually
end up just commenting out everything except for the one test I want to run,
but that's kind of lame, so I decided to write a Rake test that lets me do
this instead:

    $ rake test:this["models/the_model","this is the test"]

This works for both Rails and Minitest.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'test-this'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install test-this

After you install the gem, add this to your Rakefile to use it:

```ruby
require 'test/this'

# These are the default configuration values.
Test::This.tap do |config|
  config.file_suffix = '_test.rb'
  config.test_method_prefix = 'test_'
  config.test_path = File.join(Dir.pwd, 'test')
end
```

## Usage

To run a single test from a class full of other tests you don't want to run:

    $ rake test:this["controllers/this_controller","the name of the test"]

To test all of the tests in a class full of tests you want to run:

    $ rake test:this["controllers/this_controller"]

Note that you can leave off the trailing `_test.rb` in the name of the test and
the prefixed `test_` in the name of the test methods for Minitest. For example,
if your Minitest case looked like this:

```ruby
# file: test/something_test.rb
class SomethingTest < Minitest::Test
  def test_the_test_to_run
    assert true
  end

  def test_not_the_test_to_run
    fail
  end
end
```

To run the `test_the_test_to_run`:

    $ rake test:this["something","the test to run"]

Spaces will automatically be converted to underscores.

## Contributing

Bug reports and pull requests are welcome on GitHub at
[hi5dev/test-this](https://github.com/hi5dev/test-this).

## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).
