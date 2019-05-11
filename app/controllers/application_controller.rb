require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :sessions, true
      set :session_secret, "passwrod_security"
  end

  get "/" do
    erb :index
  end

  get "/signup" do
    erb :signup

  post "/signup" do
    user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    if user.save
      session [:user_id] = user.id
      redirect "/home"
    else
      redirect "/error"

    get "/login" do
      erb :login
    end 

end
