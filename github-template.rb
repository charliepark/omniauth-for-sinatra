%w(omniauth omniauth-github dm-core dm-sqlite-adapter dm-migrations sinatra).each { |dependency| require dependency }

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/database.db")

class User
  include DataMapper::Resource
  property :id,         Serial
  property :uid,        String
  property :name,       String
  property :nickname,   String
  property :email,      String
  property :created_at, DateTime
end

DataMapper.finalize
DataMapper.auto_upgrade!

# You'll need to customize the following line. Replace the CLIENT_ID 
#   and CLIENT_SECRET with the values you got from GitHub 
#   (https://github.com/settings/applications/new).
#
# Protip: When setting up your application's credentials at GitHub,
#   the following worked for me for local development:
#   Name: {whatever you want to call your app}
#   URL: http://localhost:4567
#   Callback URL: http://localhost:4567/auth/github/callback
#     That Callback URL should match whatever URL you have below (mine is on line 59).
#     If you use Pow or an alternate server, you'll probably use something other than
#       "http://localhost:4567"
#
# Don't save your "client ID" and "client secret" values in a publicly-available file.
use OmniAuth::Builder do
  provider :github, "CLIENT_ID", "CLIENT_SECRET"
end

enable :sessions

helpers do
  def current_user
    @current_user ||= User.get(session[:user_id]) if session[:user_id]
  end
end

get '/' do
  if current_user
    # The following line just tests to see that it's working.
    #   If you've logged in your first user, '/' should load: "1 ... 1 ... {name} ... {nickname} ... {email}";
    #   You can then remove the following line, start using view templates, etc.
    current_user.id.to_s + " ... " + session[:user_id].to_s + " ... " + current_user.name + " ... " + current_user.nickname + " ... " + current_user.email
  else
    '<a href="/sign_up">create an account</a> or <a href="/sign_in">sign in with GitHub</a>'
    # if you replace the above line with the following line, 
    #   the user gets signed in automatically. Could be useful. 
    #   Could also break user expectations.
    # redirect '/auth/twitter'
  end
end

get '/auth/:name/callback' do
  auth = request.env["omniauth.auth"]
  user = User.first_or_create({ :uid => auth["uid"]}, {
    :uid => auth["uid"],
    :name => auth["info"]["name"], 
    :nickname => auth["info"]["nickname"], 
    :email => auth["info"]["email"], 
    :created_at => Time.now })
  session[:user_id] = user.id
  redirect '/'
end

# any of the following routes should work to sign the user in: 
#   /sign_up, /signup, /sign_in, /signin, /log_in, /login
["/sign_in/?", "/signin/?", "/log_in/?", "/login/?", "/sign_up/?", "/signup/?"].each do |path|
  get path do
    redirect '/auth/github'
  end
end

# either /log_out, /logout, /sign_out, or /signout will end the session and log the user out
["/sign_out/?", "/signout/?", "/log_out/?", "/logout/?"].each do |path|
  get path do
    session[:user_id] = nil
    redirect '/'
  end
end