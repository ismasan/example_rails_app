class User < ActiveRecord::Base
  has_many :posts, :dependent => :destroy
  
  sluggable_finder :screen_name, :to => :permalink
  
  extend CommonAr::ClassMethods
  
  sortable_with :name, :email, :screen_name
  
  likeable_with :name, :email, :screen_name
  
  
  # uniform interface for lists and partials
  #
  def title
    screen_name
  end
  
end
