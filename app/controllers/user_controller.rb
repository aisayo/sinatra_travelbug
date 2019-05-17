
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
  end
end
    #redirect "/error"

  get "/login" do
    erb :login

  end

  post "/login" do
  user = User.find_by(:email => params[:email])
    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
     redirect "/home"
   else
     redirect "/"
 end
end

  get "/logout" do
      session.clear
  redirect "/login"
end

end
