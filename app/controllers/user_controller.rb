
class UserController < ApplicationController

    register Sinatra::Flash
    require 'sinatra/flash'
    enable :sessions


  get "/signup" do
    erb :signup
  end

  post "/signup" do
    user = User.new(:email => params[:email], :password => params[:password])
      if user.save
        session[:user_id] = user.id
        redirect "/home"
      else
        flash[:message] = "Something went wrong. Please try again!"
	      redirect "/signup"
      end
    end


  get "/login" do
    erb :login
  end

  post "/login" do
  user = User.find_by(:email => params[:email])
    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
     redirect "/home"
    else
     flash[:error] = "Incorrect username or password. Please try again!"
     redirect "/login"
    end
  end

  get "/logout" do
    if logged_in?
      session.clear
      redirect "/login"
    else
       flash[:error] = "Something went wrong. Please try again!"
       redirect "/"
    end
  end


end
