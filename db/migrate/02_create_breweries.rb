class CreateReviews < ActiveRecord::Migration
	def change
		create_table :reviews do |t|
			t.string :review
			t.integer :beer_id
		end
	end
end