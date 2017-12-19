class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :avatar
      t.string :cover_photo
      t.string :color
      t.string :email
      t.string :password_digest
      t.string :role

      t.timestamps
    end
  end
end
