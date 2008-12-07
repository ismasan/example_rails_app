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
  def publish_status_links(klass)
    klass_name = klass.name.tableize
    link_to_all = content_tag(:li,
      link_to("all (#{klass.count})",send(:"admin_#{klass_name}_path"), :class => "publish_status status_all"),
      :class => (current_page?(:action => :index) ? 'current' : '')
    )
    ArPublishControl::STATUSES.inject(link_to_all) do |html,status|
      html << content_tag(:li,
        link_to("#{status} (#{klass.send(status).count})",
          send(:"#{status}_admin_#{klass_name}_path"), 
          :class => "publish_status status_#{status}"),
        :class => (current_page?(:action => status) ? 'current' : '')
      )
      html
    end
  end
  
end
