module CommonAr
  
  module ClassMethods
    # sort with
    #
    # sortable_with :title, :body, :created_at
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
    
    # search with SQL LIKE
    #
    # likeable_with :title, :body
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