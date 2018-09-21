class ReviewsController < ApplicationController
	
	get '/reviews/:id' do
		@error_message = params[:error]
		if logged_in?
			@user = current_user
			@beer = Beer.find_by_id(params[:id])
			@reviews = Review.where(:beer_id => params[:id])
			erb :'/reviews/index'
		else	
			redirect "/login?error=You have to be logged in to see a review."
		end
	end
	
	get '/reviews/:id/show' do
		@error_message = params[:error]
		if logged_in?
			@user = current_user
			@review = Review.find_by_id(params[:id])
			@beer = Beer.find_by_id(@review.beer_id)
			erb :'/reviews/show'
		else
			redirect "/login?error=You have to be logged in to see a review."
		end
	end
	
	get '/reviews/:id/new' do
		if logged_in?
			@user = current_user
			@beer = Beer.find_by_id(params[:id])
			erb :'/reviews/new'
		else
			redirect "/login?error=You have to be logged in to write a new review."
		end
	end
	
	post '/reviews/:id' do
		if logged_in?
			if params[:review] != ""
				user = current_user
				@review = Review.create(date: params[:date], summary: params[:summary], review: params[:review])
				@review.beer_id = params[:id]
				@beer = Beer.find_by_id(params[:id])
				@review.save
				erb :'/reviews/show'
			else 
				'/reviews/' + params[:id] + '/new?error=Review cannot be blank'
			end
		else
			redirect "/login?error=You have to be logged in to write a new review."
		end
	end
	
	get '/reviews/:id/edit' do
		@error_message = params[:error]
		@review = Review.find_by_id(params[:id])
		@beer = Beer.find_by_id(@review.beer_id)
		if logged_in? && current_user.id == @review.beer.user.id
			erb :'/reviews/edit'
		elsif logged_in?	
			redirect '/reviews/' + @review.beer_id.to_s
		else
			redirect "/login?error=You have to be logged in to edit a review."
		end
	end
	
	patch '/reviews/:id' do
		@review = Review.find_by_id(params[:id])
		if logged_in?
			if current_user.id == @review.beer.user.id
				if params[:review] != ""
					@review.date = params[:date]
					@review.summary = params[:summary]
					@review.review = params[:review]
					@review.save
					redirect '/reviews/'+ @review.beer_id.to_s
				else
					redirect '/reviews/' + params[:id] + '/edit?error=Review cannot be blank.'
				end
			else
				redirect '/reviews/'+ @review.beer_id.to_s
			end
		else
			redirect "/login?error=You have to be logged in to edit a review."
		end
	end
	
	delete '/reviews/:id' do
		@review = Review.find_by_id(params[:id])
		if current_user.id == @review.beer.user.id
			@review.delete
			redirect '/reviews/'+ @review.beer_id.to_s
		elsif logged_in?
			redirect '/reviews/' + @review.beer_id.to_s
		else
			redirect "/login?error=You have to be logged in to delete a review."
		end
	end

end
