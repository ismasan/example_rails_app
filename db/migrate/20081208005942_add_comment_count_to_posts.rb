class AddCommentCountToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :comments_count, :integer, :default => 0
  end

  def self.down
    remove_column :posts, :comments_count
  end
end
