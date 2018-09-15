class BeersController < ApplicationController
	get '/beers' do
		#if logged_in?
			@user = current_user
			@beers = Beer.all
			erb :'beers/index'
		#else
			#redirect '/login'
		#end
	end
	
	get '/beers/new' do
		#if logged_in?
			erb :'beers/new'
		#else
			#redirect '/login'
		#end
	end
	
	post '/beers' do
		user = current_user
		beer = Beer.create(name: params[:name], beer_type: params[:beer_type], brewery: params[:brewery])
		beer.user = current_user
		beer.save
		redirect '/beers'
	end
		
		
end
