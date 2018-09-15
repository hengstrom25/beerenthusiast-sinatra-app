class CreateBeers < ActiveRecord::Migration[4.2]
	def change
		create_table :beers do |t|
			t.string :name
			t.string :beer_type
			t.string :brewery
			t.integer :user_id
		end
	end		
end