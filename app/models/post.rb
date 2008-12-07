class Post < ActiveRecord::Base
  
  #has_many :comments, :dependent => :destroy
  
  has_many :comments, :class_name => 'Comment', :conditions => Comment.published_conditions
  
  sluggable_finder :title
  
  publish_control
  
  def self.per_page
    10
  end
  
end
