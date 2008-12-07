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
      "<span class='publish_status status_upcoming'>UPCOMING</span> on #{m.publish_at.to_s(:short)}"
    elsif m.expired?
      "<span class='publish_status status_expired'>EXPIRED</span> on #{m.unpublish_at.to_s(:short)}"
    elsif m.published?
      ss = "<span class='publish_status status_published'>PUBLISHED</span> on #{m.publish_at.to_s(:short)}"
      ss << " &rarr; #{m.unpublish_at.to_s(:short)}" if m.unpublish_at
      ss
    else
      "<span class='publish_status status_draft'>DRAFT</span>"
    end
  end
  
end
