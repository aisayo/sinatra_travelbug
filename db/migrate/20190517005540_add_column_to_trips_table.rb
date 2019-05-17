class AddColumnToTripsTable < ActiveRecord::Migration
  def change
      add_column :trips, :date, :text 
  end
end
