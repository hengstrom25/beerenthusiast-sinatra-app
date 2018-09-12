class CreateBeers < ActiveRecord::Migration[4.2]
	def change
		create_table :beers do |t|
			t.string :name
			t.string :type
			t.string :brewery
			t.integer :users_id
		end
	end		
end