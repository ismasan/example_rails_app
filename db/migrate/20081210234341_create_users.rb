class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :permalink
      t.string :screen_name
      t.timestamps
    end
    add_column :posts, :user_id, :integer
    add_index :posts, :user_id
  end

  def self.down
    drop_table :users
    remove_column :posts, :user_id
  end
end
