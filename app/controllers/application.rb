# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '364fc6f9d31b0a82fdfb6034683847d4'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  helper_method :resource_service
  
  protected
  
  # this creates actions for each publish status, which call find_resources with the correct scope
  def self.publish_status_actions
    ArPublishControl::STATUSES.each do |action|
      define_method action do
        self.resources = find_resources(action)
        render :action => :index
      end
    end
  end
  
  def find_resources(scope = :all)
    params[:sort] ||= resource_service.sortable_fields.keys.first
    resource_service.sort_by(params[:sort]).paginate(:page => params[:page])
    #resource_service.send(scope).sort_by(params[:sort]).paginate(:page => params[:page])
  end
  
end
