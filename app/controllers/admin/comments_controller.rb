class Admin::CommentsController < Admin::AdminController
  resources_controller_for :comments
  
  publish_status_actions
  
end
