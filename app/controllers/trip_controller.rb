class TripController < ApplicationController

  get "/home" do
    if logged_in? && current_user
      @user = current_user
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
    if logged_in? && params[:name] != "" && params[:location] != "" && params[:date] != ""
      @trip = Trip.create(name: params[:name], location: params[:location], date: params[:date])
      @user.trips << @trip
      redirect "/trips/#{@trip.id}"
    else
      flash[:error] = "All fields must be filled in"
      redirect '/trips/new'
    end
  end

  get '/trips/:id' do
    if logged_in?
      @trips = Trip.find_by_id(params[:id])
      erb :'/trips/show'
    end
  end

  get '/trips/:id/edit' do
    if logged_in?
      @trips = Trip.find_by_id(params[:id])
		  erb :'/trips/edit'
    else
       redirect '/login'
    end
  end

  patch '/trips/:id' do
      if logged_in? && params[:location] != "" && params[:date] != ""
        @trips = Trip.find_by_id(params[:id])
        @trips.location = params[:location]
        @trips.date = params[:date]
        @trips.save
        redirect to "/trips/#{@trips.id}"
      else
        flash[:error] = "All fields must be filled in"
        redirect "/trips/#{@trips.id}"
      end
   end

  delete '/trips/:id' do
		@trips = Trip.find(params[:id])
		if current_user = @trips.user
			@trips.destroy
	  	redirect "/home"
    end
  end


end
