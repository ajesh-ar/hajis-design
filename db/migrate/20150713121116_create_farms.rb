class CreateFarms < ActiveRecord::Migration
  def change
    create_table :farms do |t|
      t.string :name
      t.string :street
      t.string :place
      t.float :latitude
      t.float :longitude
      t.string :state
      t.string :country, default: 'India'
      t.string :phone

      t.timestamps
    end
  end
end
