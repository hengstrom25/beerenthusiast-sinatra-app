class BeersController < ApplicationController
	get '/beers' do
		@beers = Beer.all
		erb :'beers/index'
	end
	
	get '/beers/new' do
		erb :'beers/new'
	end
		
		
end
