class CommentsController < ApplicationController
  resources_controller_for :comments
  
  def find_resources
    bool = params[:all].nil? || params[:all] == 1
    @comments = resource_service.published_only(bool).paginate(:page=>params[:page])
  end
  
end
