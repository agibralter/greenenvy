# Greenenvy

Greenenvy is yet another configuration DSL for Ruby applications. It provides a system for clearly
declaring environment-specific settings, such as third-party API keys and endpoints.

This project was heavily inspired by https://github.com/jcmuller/figleaf and others.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'greenenvy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install greenenvy

## Usage

For example, for use in a Rails application, you could add Greenenvy to your
`config/application.rb`:

```ruby
require_relative 'boot'

require "rails"
# ...

Bundler.require(*Rails.groups)

module MyApp
  class Application < Rails::Application

    # Load config/settings/*.rb with Greenenvy gem
    ::Settings = Greenenvy.load_env(
      Rails.env,
      Rails.root.join("config", "settings"),
    )

    config.load_defaults 5.2
  end
end
```

Given the following file in `config/settings/some_settings.rb`:

```ruby

# Default applies to all environments
default do
  set :enabled, false
  set :api_key, ENV["SOME_API_KEY"]
end

# Env-specific takes precedence over the defaults
env :production do
  set :enabled, true
end
```

You could call the following in your Rails code:

```ruby
# Note `some_settings` is the name of the `.rb` file above.
api_key = Settings.some_settings.api_key
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake test` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/agibralter/greenenvy. This project is intended to be a safe,
welcoming space for collaboration, and contributors are expected to adhere to
the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT
License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Greenenvy project’s codebases, issue trackers, chat
rooms and mailing lists is expected to follow the [code of
conduct](https://github.com/agibralter/greenenvy/blob/master/CODE_OF_CONDUCT.md).
