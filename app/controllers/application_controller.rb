require './config/environment'

class ApplicationController < Sinatra::Base

	configure do
		set :public_folder, 'public'
		set :views, 'app/views'
		enable :sessions
		set :session_secret, "experiment"
	end
	
	get '/' do
		erb :index
	end
	
	helpers do
	
		def logged_in?
			!!session[:user_id]
		end
		
		def current_user
			User.find_by_id(session[:user_id])
		end
	end
end
	
			