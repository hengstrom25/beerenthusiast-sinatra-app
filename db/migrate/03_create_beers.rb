class CreateBeers < ActiveRecord::Migration
	def change
		create_table :beers do |t|
			t.string :name
			t.string :type
			t.string :brewery
			t.integer :users_id
		end
	end		
end