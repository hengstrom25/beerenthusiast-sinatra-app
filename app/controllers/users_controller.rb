class UsersController < ApplicationController

	#gets '/users/:id' do
		#if !logged_in?
			#redirect '/'
		#end
	#end
		
	#@user = User.find(params[:id])
	#if !@user.nil? && @user == current_user
		#erb :'users/show'
	#else
		#redirect '/'
	#end
	
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
	
	#get '/login' do
		#user = User.find_by(:username => params[:username])
			#if user && user.authenticate(params[:password])
				#session[:user_id] = user.id
				#redirect '/beers'
			#else
				#redirect '/signup'
			#end
	#end
				
	
end
