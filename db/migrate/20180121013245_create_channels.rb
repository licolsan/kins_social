class CreateChannels < ActiveRecord::Migration[5.1]
  def change
    create_table :channels do |t|

      t.timestamps
    end
  end
end