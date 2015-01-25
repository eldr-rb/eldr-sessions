# Eldr::Sessions [![Build Status](https://travis-ci.org/eldr-rb/eldr-sessions.svg)](https://travis-ci.org/eldr-rb/eldr-sessions) [![Code Climate](https://codeclimate.com/github/eldr-rb/eldr-sessions/badges/gpa.svg)](https://codeclimate.com/github/eldr-rb/eldr-sessions) [![Coverage Status](https://coveralls.io/repos/eldr-rb/eldr-sessions/badge.svg?branch=master)](https://coveralls.io/r/eldr-rb/eldr-sessions?branch=master) [![Dependency Status](https://gemnasium.com/eldr-rb/eldr-sessions.svg)](https://gemnasium.com/eldr-rb/eldr-sessions) [![Inline docs](https://inch-ci.org/github/eldr-rb/eldr-sessions.svg?branch=master)](http://inch-ci.org/github/eldr-rb/eldr-sessions) [![Gratipay](https://img.shields.io/gratipay/k2052.svg)](https://www.gratipay.com/k2052)

Provides session helpers like `signed_in?` and `current_user` for [Eldr](https://github.com/eldr-rb/eldr) apps and Rack apps.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'eldr-sessions'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install eldr-sessions

## Usage

Eldr::Sessions is designed to be included in a Eldr app or Rack app. It has two dependencies;

1. Session access via `env['rack.session']`
2. A configuration object with a `session_id` and `user_model` accessor.

If you use it in a Eldr app these two things are already available and you only need to set a session_id.

Use it an Eldr::App like this:

```ruby
class App < Eldr::App
  include Eldr::Sessions

  use Rack::Session::Cookie, secret: 'sessions_secret'
  set :session_id, 'sessionsRawesome'

  get '/greeting' do
    if current_user
      Rack::Response.new "Hello #{current_user.name}!"
    else
      Rack::Response.new('Login First!', 401)
    end
  end

  post '/login' do
    user = User.authenticate(params['email'], params['password'])
    set_current_user user
    Rack::Response.new('Logged In!')
  end
end
```

See [examples/app.ru](https://github.com/eldr-rb/eldr-sessions/tree/master/examples/app.ru) for an example app.

## Contributing

1. Fork. it
2. Create. your feature branch (git checkout -b cat-evolver)
3. Commit. your changes (git commit -am 'Add Cat Evolution')
4. Test. your changes (always be testing)
5. Push. to the branch (git push origin cat-evolver)
6. Pull. Request. (for extra points include funny gif and or pun in comments)

To remember this you can use the easy to remember and totally not tongue-in-check initialism: FCCTPP.

I don't want any of these steps to scare you off. If you don't know how to do something or are struggle getting it to work feel free to create a pull request or issue anyway. I'll be happy to help you get your contributions up to code and into the repo!

## License

Licensed under MIT by K-2052.
