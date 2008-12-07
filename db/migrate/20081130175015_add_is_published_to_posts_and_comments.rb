class AddIsPublishedToPostsAndComments < ActiveRecord::Migration
  def self.up
    add_column :posts, :is_published, :boolean, :default => true
    add_column :comments, :is_published, :boolean, :default => true
  end

  def self.down
    remove_column :posts, :is_published
    remove_column :posts, :is_published
  end
end
