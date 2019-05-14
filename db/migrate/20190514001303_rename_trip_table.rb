class RenameTripTable < ActiveRecord::Migration
  def change
    rename_table :trip, :trips 
  end
end
