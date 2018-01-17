class CreateReacts < ActiveRecord::Migration[5.1]
  def change
    create_table :reacts do |t|
      t.integer :user_id
      t.integer :post_id
      t.integer :comment_id
      t.integer :react_type

      t.timestamps
    end
  end
end
