class Review < ActiveRecord::Base
	belongs_to :beer
	
	#def beer
		#Beer.find_by_id(@beer_id)
	#end

end