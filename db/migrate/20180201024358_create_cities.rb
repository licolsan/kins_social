class CreateCities < ActiveRecord::Migration[5.1]
  def change
    create_table :cities do |t|
      t.string :name
      t.integer :country_id
    end
    add_index :cities, [:name, :country_id], unique: true
  end
end
