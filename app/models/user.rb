class User < ActiveRecord::Base
	has_secure_password
	has_many :beers
	has_many :reviews, through: :beers
	
end
	