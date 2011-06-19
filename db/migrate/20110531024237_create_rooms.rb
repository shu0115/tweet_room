class CreateRooms < ActiveRecord::Migration
  def self.up
    create_table :rooms do |t|
      t.integer :user_id
      t.string :title
      t.string :hash_tag
      t.string :mode
      t.string :synchro_flag
      t.string :keep_flag
      t.text :external_site

      t.timestamps
    end
  end

  def self.down
    drop_table :rooms
  end
end
