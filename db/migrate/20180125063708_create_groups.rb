class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :avatar
      t.string :cover_photo
      t.string :group_type
      t.text :description

      t.timestamps
    end
  end
end
