require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
    use Rack::Flash
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

  get "/home" do
    @trips = Trip.all
    erb :home
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

  get "/trips/new" do
		erb :'trips/new'
	end

  post '/trips' do

			@trips = Trip.create(params[:trip])
           @trips = current_user.trips.create(name: params[:name], location: params[:location])

           @trips.user = current_user
     @trips.save
     redirect "trips/new"

               #redirect "/trips/#{@trip.id}"
          #{} else
        #  flash[:message] = "A trip name is required"

     end

       get '/trips/:id/edit' do
		@trips = Trip.find(params[:id])
		erb :'/trips/edit'
	end

  get '/trips/:id' do
		@trips = Trip.find(params[:id])
		erb :'/trips/show'
	end

  post '/trips/:id' do
		@trips = Trip.find(params[:id])

			redirect "/trips/#{@trips.id}"

	end


   end
