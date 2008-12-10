class Admin::PostsController < Admin::AdminController
  
  resources_controller_for :posts
  
  publish_status_actions
  
end
