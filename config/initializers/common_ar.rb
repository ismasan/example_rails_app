module CommonAr
  
  module ClassMethods
    # Sort given fields ASC or DESC
    #
    # Example:
    #
    # class Post < ActiveRecord::Base
    #   extend CommonAr::ClassMethods
    #
    #   sortable_with :title, :created_at
    # end
    #
    # Now you can sort with: 
    # 'title_asc'
    # 'title_desc'
    # 'created_at_asc'
    # 'created_at_desc'
    #
    # @posts = Post.sort_with(params[:sort]).paginate(:page => params[:page])
    #
    def sortable_with(*fields)
      sorts = fields.inject({}) do |h,f|
        h[:"#{f}_asc"] = "#{f} ASC"
        h[:"#{f}_desc"] = "#{f} DESC"
        h
      end
      write_inheritable_attribute(:sortable_fields,sorts)
      class_inheritable_reader :sortable_fields
      named_scope :sort_with, lambda { |*args|
        return {} if args.compact.blank?
        {:order => sortable_fields[args.first.to_sym]}
      }
    end
    
    # Search given fields with SQL LIKE
    #
    # Example:
    #
    # class Post < ActiveRecord::Base
    #   extend CommonAr::ClassMethods
    #
    #   likeable_with :title, :body
    # end
    #
    # Now your LIKE queries will look in title and body
    # You can combine scopes.
    #
    # @posts = Post.sort_with(params[:sort]).like(params[:q]).paginate(:page => params[:page])
    #
    def likeable_with(*fields)
      # TODO: validate that schema has these fields
      named_scope :like, lambda {|q|
        return {} if q.blank? || !q.respond_to?(:to_s)
        t = ActiveRecord::Base.connection.quote("%#{q}%")
        conditions = fields.collect{|f| "#{f} LIKE #{t}" }.join(' OR ')
        {:conditions => conditions}
      }
    end
    
  end

  
end