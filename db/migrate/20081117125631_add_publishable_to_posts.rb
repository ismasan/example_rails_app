class AddPublishableToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :publish_at, :datetime
    add_column :posts, :unpublish_at, :datetime
  end

  def self.down
    remove_column :posts, :publish_at
    remove_column :posts, :unpublish_at
  end
end
