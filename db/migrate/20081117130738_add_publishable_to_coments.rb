class AddPublishableToComents < ActiveRecord::Migration
  def self.up
    add_column :comments, :publish_at, :datetime
    add_column :comments, :unpublish_at, :datetime
  end

  def self.down
    remove_column :comments, :publish_at
    remove_column :comments, :unpublish_at
  end
end
