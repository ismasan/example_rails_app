class Admin::PostsController < Admin::AdminController
  include ExceptionNotifiable
  local_addresses.clear
  resources_controller_for :posts
  
  ArPublishControl::STATUSES.each do |action|
    define_method action do
      find_resources(action)
      render :action => :index
    end
  end
  
  protected
  
  def find_resource
    @post = @resource = Post.find(params[:id])
  end
  
  def find_resources(scope = :all)
    @posts = @resources = Post.send(scope).paginate(:page => params[:page])
  end
  
end
