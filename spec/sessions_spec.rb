class TestApp
  include Eldr::Sessions
  attr_accessor :env, :configuration

  def initialize
    @configuration = Eldr::Configuration.new
  end

  def call(env)
    @env = env
  end
end

describe Eldr::Sessions do
  let(:app) { TestApp.new }

  let(:env) do
    Rack::MockRequest.env_for('/', {:method => :get, 'rack.session' => {'cats' => 'bob'}})
  end

  describe '#session' do
    it 'returns the session data' do
      app.call(env)
      expect(app.session['cats']).to eq('bob')
    end
  end

  describe '#session_id' do
    context 'when there is a session_id' do
      it 'returns the session_id' do
        app.configuration.session_id = 'sessionsRAwesome'
        expect(app.session_id).to eq('sessionsRAwesome')
      end
    end

    context 'when there is no set session_id' do
      it 'throws an error' do
        app.configuration.session_id = nil
        expect { app.session_id }.to raise_error
      end
    end
  end

  describe '#user_model_obj' do
    context 'when there is a user_model set on configuration' do
      it 'returns it' do
        Bob = Class.new()
        app.configuration.user_model = 'Bob'
        expect(app.user_model_obj).to eq Bob
        app.configuration.user_model = nil
      end
    end

    context 'when there is no user_model set on configuration' do
      it 'returns the default' do
        expect(app.user_model_obj).to eq User
      end
    end
  end

  describe '#login_from_session' do
    context 'when there is a set user' do
      it 'returns that user' do
        app.configuration.session_id = 'sessionsRAwesome'
        app.call(env)

        user = User.create(name: 'bob')
        app.set_current_user user
        expect(app.login_from_session).to eq user
      end
    end
  end
end
