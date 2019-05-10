class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trip do |t|
      t.string :name
      t.string :location 
      t.integer :user_id
    end
  end
end
