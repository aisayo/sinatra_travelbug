class TripController < ApplicationController

  get "/home" do
    if logged_in? && current_user
      @user = current_user
      binding.pry
      session[:user_id] = @user.id
      @trips = @user.trips
      erb :home
    else
      redirect '/login'
    end
  end

  get "/trips/new" do
		erb :'trips/new'
	end

  post '/trips' do
    @user = current_user
    if logged_in? && params[:name] != "" && params[:location] != ""
      @trip = Trip.create(name: params[:name], location: params[:location])
      @user.trips << @trip
      redirect "/trips/#{@trip.id}"
    else
      redirect '/trips/new'
    end
  end

  get '/trips/:id' do
    if logged_in?
      @user =  current_user
      @trips = Trip.find(params[:id])
      erb :'/trips/show'
    end
  end

  get '/trips/:id/edit' do
		@trips = Trip.find(params[:id])
		erb :'/trips/edit'
	end

  post '/trips/:id' do
	   @trips = Trip.find(params[:id])
     redirect "/trips/#{@trips.id}"
	end

  delete '/trips/:id' do
		@trips = Trip.find(params[:id])
		if current_user = @trips.user
			@trips.destroy
		else
			flash[:message] = "You cannot delete trips you did not create"
		end
		redirect "/home"
  end


end
