class Post < ActiveRecord::Base
  
  has_many :comments, :dependent => :destroy
  
  sluggable_finder :title
  
  publish_control
  
  extend CommonAr::ClassMethods
  
  sortable_with :title, :publish_at, :comments_count
  
  likeable_with :title, :body
  
end
