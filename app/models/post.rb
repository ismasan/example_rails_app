class Post < ActiveRecord::Base
  
  has_many :comments, :dependent => :destroy
  
  sluggable_finder :title
  
  publish_control
  
  extend CommonAr::ClassMethods
  
  sortable_with :title, :publish_at, :created_at
  
end
