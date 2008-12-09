class Comment < ActiveRecord::Base
  belongs_to :post, :counter_cache => true
  
  named_scope :recent, lambda{|limit|
    {:limit => limit}
  }
  
  
  publish_control
  
  extend CommonAr::ClassMethods
  
  sortable_with :publish_at, :created_at
  
end
