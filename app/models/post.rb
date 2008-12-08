class Post < ActiveRecord::Base
  
  has_many :comments, :dependent => :destroy
  
  sluggable_finder :title
  
  publish_control
  
  def self.per_page
    10
  end
  
end
