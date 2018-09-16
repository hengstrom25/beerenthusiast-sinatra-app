class ReviewsController < ApplicationController
	
	get '/reviews/:id' do
		if logged_in?
			@user = current_user
			@beer = Beer.find_by_id(params[:id])
			@reviews = Review.where(:beer_id => params[:id])
			erb :'/reviews/index'
		else	
			redirect '/login'
		end
	end
	
	get '/reviews/:id/new' do
		if logged_in?
			@user = current_user
			@beer = Beer.find_by_id(params[:id])
			erb :'/reviews/new'
		else
			redirect '/login'
		end
	end
	
	post '/reviews/:id' do
		if logged_in?
			@user = current_user
			@beer = Beer.find_by_id(params[:id])
			erb :'/reviews/show'
		else
			redirect '/login'
		end
	
	
	
	end

end
