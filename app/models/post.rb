class Post < ActiveRecord::Base
  
  belongs_to :user
  
  has_many :comments, :dependent => :destroy
  
  sluggable_finder :title
  
  publish_control
  
  extend CommonAr::ClassMethods
  
  sortable_with :title, :publish_at, :comments_count
  
  likeable_with :title, :body
  
end
