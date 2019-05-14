require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end
	end

  get "/" do
    erb :index
  end

  get "/signup" do
    erb :signup
  end

  post "/signup" do
    user = User.new(:email => params[:email], :password => params[:password])
    if user.save
    session[:user_id] = user.id
      redirect "/home"
    end
  end
      #redirect "/error"

    get "/login" do
       user = User.find_by(:email => params[:email])
      erb :login

    end

    post "/login" do
		user = User.find_by(:email => params[:email])
	    if user && user.authenticate(params[:password])
	        session[:user_id] = user.id
	     redirect "/home"
     #else
       #redirect "/"

   end

	    end


      get "/home" do
        erb :home
  end
end
