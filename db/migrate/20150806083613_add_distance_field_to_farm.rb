class AddDistanceFieldToFarm < ActiveRecord::Migration
  def change
  	add_column :farms, :distance, :float
  end
end
