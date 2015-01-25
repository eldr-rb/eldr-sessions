require 'eldr'
require 'mongo_mapper'
require_relative '../lib/eldr/sessions'

MongoMapper.setup({'test' => {'uri' => 'mongodb://localhost:27017/eldr_sessions'}}, 'test')

class User
  include MongoMapper::Document
  key :name,  String
  key :email, String

  def self.authenticate(email, password)
    find_by_email(email)
  end
end

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

run App
