class CreateMemberShips < ActiveRecord::Migration[5.1]
  def change
    create_table :member_ships do |t|
      t.integer :user_id
      t.integer :group_id
      t.boolean :is_owner, default: false
      t.boolean :is_admin, default: false

      t.timestamps
    end
    add_index :member_ships, [:user_id, :group_id], unique: true
  end
end
