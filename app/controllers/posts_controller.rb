class PostsController < ApplicationController
  include ExceptionNotifiable
  local_addresses.clear
  resources_controller_for :posts
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      flash[:notice] = 'Post updated'
      redirect_to @post
    else
      render :action => :edit
    end
  end
  
  protected
  
  def find_resource
    Post.published.find(params[:id])
  end
  
  def find_resources
    @posts = Post.published.paginate(:page => params[:page])
  end
  
end
