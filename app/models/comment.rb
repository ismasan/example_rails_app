class Comment < ActiveRecord::Base
  belongs_to :post
  
  named_scope :recent, lambda{|limit|
    {:order => 'created_at desc',:limit => limit}
  }
  
  named_scope :desc, :order => 'created_at desc'
  
  publish_control
  
  
end
