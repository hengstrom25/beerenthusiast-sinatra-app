class UsersController < ApplicationController

	get '/users/:id' do
		@user = User.find_by_id(params[:id])
		erb :'users/show'
	end
	
	get '/signup' do
		if !session[:user_id]
			erb :'users/new'
		else
			redirect to '/beers/'
		end
	end
	
	post '/signup' do
		if params[:username] == "" || params[:password] == ""
			redirect to '/signup'
		else
			@user = User.create(:username => params[:username], :password => params[:password])
			session[:user_id] = @user.id
			redirect '/beers'
		end
	end
	
	get '/login' do
		if !session[:user_id]
			erb :'users/login'
		else	
			redirect '/beers'
		end
	end
			
	
	post '/login' do
		user = User.find_by(:username => params[:username])
			if user && user.authenticate(params[:password])
				session[:user_id] = user.id
				redirect '/beers'
			else
				redirect '/signup'
			end
	end
	
	get '/logout' do
		if session[:user_id] !=nil
			session.destroy
			redirect '/login'
		else
			redirect '/'
		end
	end			
	
end
