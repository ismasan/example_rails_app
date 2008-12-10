# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # a thumbnail for an object, or placeholder image
  #
  def thumbnail_for(model,size = :thumbnail)
    path = if model.respond_to?(:preview_image) and !model.preview_image.blank?
      model.preview_image(size)
    else
      File.join('placeholders',model.class.name.tableize,"#{size}.png")
    end
    image_tag path, :alt => (model.respond_to?(:title) ? h(model.title) : model.class.name)
  end
  
  # sort_links for this controller's resource_service
  # service is expected to repond_to :sortable_fields
  #
  def sort_links
    resource_service.sortable_fields.collect do |key,value|
    	link_to key, params.dup.update(:sort => key), :class => ((params[:sort].to_s==key.to_s) ? 'current' : '')
    end.join(' | ')
  end
  
  # :published
  # :expired
  # :upcoming
  # :draft
  #
  def publish_status_for(m)
    s = if m.upcoming?
      "<span class='publish_status status_upcoming'>UPCOMING</span> on #{m.publish_at.to_s(:day_month_year)}"
    elsif m.expired?
      "<span class='publish_status status_expired'>EXPIRED</span> on #{m.unpublish_at.to_s(:day_month_year)}"
    elsif m.published?
      ss = "<span class='publish_status status_published'>PUBLISHED</span> on #{m.publish_at.to_s(:day_month_year)}"
      ss << " &rarr; #{m.unpublish_at.to_s(:day_month_year)}" if m.unpublish_at
      ss
    else
      "<span class='publish_status status_draft'>DRAFT</span>"
    end
  end
  
  # list of links to publish statuses for a model
  #
  def publish_status_links(klass, parent=nil)
    parent_path = parent ? "#{parent.class.name.underscore}_" : ''
    klass_name = klass.name.tableize
    pars = {:sort => params[:sort], :q => params[:q]}
    h = content_tag(:li,
      link_to("all (#{klass.count})",send(*[:"admin_#{parent_path}#{klass_name}_path",parent,pars.except(:q)].compact), 
        :class => "publish_status status_all"),
      :class => ((controller.action_name == 'index' && pars[:q].blank?) ? 'current' : '')
    )
    if pars[:q]
      h << content_tag(:li,
        link_to("all results (#{klass.like(pars[:q]).count})",
          send(*[:"admin_#{parent_path}#{klass_name}_path",parent,pars].compact), 
          :class => "publish_status status_all"),
        :class => (controller.action_name == 'index' ? 'current' : '')
      )
    end
    ArPublishControl::STATUSES.inject(h) do |html,status|
      html << content_tag(:li,
        link_to("#{status} (#{klass.send(status).like(pars[:q]).count})",
          send(*[:"#{status}_admin_#{parent_path}#{klass_name}_path",parent,pars].compact), 
          :class => "publish_status status_#{status}"),
        :class => (controller.action_name == status.to_s ? 'current' : '')
      )
      html
    end
    h << content_tag(:li,link_to("&larr; back to %s index"%klass_name,send(:"admin_#{klass_name}_path"))) if parent
    h
  end
  
end
