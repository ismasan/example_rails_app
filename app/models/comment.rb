class Comment < ActiveRecord::Base
  belongs_to :post, :counter_cache => true
  
  named_scope :recent, lambda{|limit|
    {:limit => limit}
  }
  
  named_scope :desc, :order => 'created_at desc'
  
  publish_control
  
  
end
