class AddCommentCountToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :comment_count, :integer, :default => 0
  end

  def self.down
    remove_column :posts, :comment_count
  end
end
