module CommonAr
  
  module ClassMethods
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
  end
  
end