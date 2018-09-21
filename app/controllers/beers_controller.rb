class BeersController < ApplicationController
	get '/beers' do
		if logged_in?
			@user = current_user
			@beers = Beer.where(:user_id => current_user.id)
			erb :'beers/index'
		else
			redirect "/login?error=You have to be logged in to see your list of beers."
		end
	end
	
	get '/beers/new' do
		if logged_in?
			erb :'beers/new'
		else
			redirect "/login?error=You have to be logged in to create a new beer."
		end
	end
	
	get '/beers/:id' do
		if logged_in?
			@beer = Beer.find_by_id(params[:id])
			erb :'beers/show'
		else
			redirect "/login?error=You have to be logged in to see a particular beer."
		end
	end
		
	get '/beers/:id/edit' do
		@beer = Beer.find_by_id(params[:id])
		if logged_in? && current_user.id == @beer.user.id
			erb :'beers/edit'
		elsif logged_in?
			redirect '/beers'
		else
			redirect "/login?error=You have to be logged in to edit a beer."
		end
	end
	
	patch '/beers/:id' do
		@beer = Beer.find_by_id(params[:id])
		if logged_in? && current_user.id == @beer.user.id
			@beer.name = params[:name]
			@beer.beer_type = params[:beer_type]
			@beer.brewery = params[:brewery]
			@beer.save
			redirect '/beers'
		elsif logged_in?
			redirect '/beers'
		else 
			redirect "/login?error=You have to be logged in to edit a beer."
		end	
	end
	
	post '/beers' do
		user = current_user
		beer = Beer.create(name: params[:name], beer_type: params[:beer_type], brewery: params[:brewery])
		beer.user = current_user
		beer.save
		redirect '/beers'
	end
	
	delete '/beers/:id' do
		@beer = Beer.find_by_id(params[:id])
		if current_user.id == @beer.user.id
			@beer.delete
			redirect '/beers'
		elsif logged_in?
			redirect '/beers'
		else
			redirect "/login?error=You have to be logged in to delete a beer."
		end
	end
		
		
end
