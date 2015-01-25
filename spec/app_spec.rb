describe 'App' do
  let(:app) do
    path = File.expand_path('../examples/app.ru', File.dirname(__FILE__))
    Rack::Builder.parse_file(path).first
  end

  let(:rt) do
    Rack::Test::Session.new(app)
  end

  describe 'GET /greeting' do
    context 'when not logged in' do
      it 'askes you to login' do
        response = rt.get '/greeting'
        expect(response.status).to eq(401)
        expect(response.body).to eq('Login First!')
      end
    end

    context 'POST /login' do
      it 'logins a user' do
        user = User.create(email: 'bob@email.com', name: 'Bob')
        rt.post '/login', {email: user.email}
        response = rt.get '/greeting'
        expect(response.status).to eq(200)
        expect(response.body).to eq("Hello #{user.name}!")
      end
    end
  end
end
