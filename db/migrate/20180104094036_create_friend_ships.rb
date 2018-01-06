class CreateFriendShips < ActiveRecord::Migration[5.1]
  def change
    create_table :friend_ships do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
