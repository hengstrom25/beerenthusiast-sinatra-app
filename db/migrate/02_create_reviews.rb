class CreateReviews < ActiveRecord::Migration[4.2]
	def change
		create_table :reviews do |t|
			t.string :date
			t.string :summary
			t.string :review
			t.integer :beer_id
		end
	end
end