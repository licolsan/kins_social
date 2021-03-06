class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.integer :post_id
      t.integer :user_id
      t.text :reason

      t.timestamps
    end
    add_index :reports, [:post_id, :user_id], unique: true
  end
end
