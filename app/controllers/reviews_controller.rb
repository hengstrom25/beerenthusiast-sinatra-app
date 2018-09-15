class ReviewsController < ApplicationController

	get '/reviews' do
		@reviews = Review.all
		erb :'reviews/index'
	end

end
