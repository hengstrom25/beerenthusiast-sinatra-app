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
	
	get '/reviews/:id/show' do
		if logged_in?
			@user = current_user
			@review = Review.find_by_id(params[:id])
			@beer = Beer.find_by_id(@review.beer_id)
			erb :'/reviews/show'
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
			user = current_user
			@review = Review.create(date: params[:date], summary: params[:summary], review: params[:review])
			@review.beer_id = params[:id]
			@beer = Beer.find_by_id(params[:id])
			@review.save
			erb :'/reviews/show'
		else
			redirect '/login'
		end
	end
	
	get '/reviews/:id/edit' do
		@review = Review.find_by_id(params[:id])
		@beer = Beer.find_by_id(@review.beer_id)
		if logged_in? && current_user.id == @beer.user.id
			erb :'/reviews/edit'
		elsif logged_in?	
			redirect '/reviews/' + @review.beer_id.to_s
		else
			redirect '/login'
		end
	end
	
	patch '/reviews/:id' do
		@review = Review.find_by_id(params[:id])
		@review.date = params[:date]
		@review.summary = params[:summary]
		@review.review = params[:review]
		@review.save
		redirect '/reviews/'+ @review.beer_id.to_s
	end
	
	delete '/reviews/:id' do
		@review = Review.find_by_id(params[:id])
		if current_user.id == @review.beer.user.id
			@review.delete
			redirect '/reviews/'+ @review.beer_id.to_s
		else
			redirect '/beers'
		end
	end

end
