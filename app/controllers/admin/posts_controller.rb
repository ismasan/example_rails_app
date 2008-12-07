class Admin::PostsController < Admin::AdminController
  include ExceptionNotifiable
  local_addresses.clear
  
  resources_controller_for :posts
  
  publish_status_actions
  
end
