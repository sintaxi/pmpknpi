module Merb
  module GlobalHelpers
    include Merb::Helpers::RailsDateAndTime
    
    def pluralize(count, singular, plural = nil)
       "#{count || 0} " + if count == 1 || count == '1'
        singular
      elsif plural
        plural
      elsif Object.const_defined?("Inflector")
        Inflector.pluralize(singular)
      else
        singular + "s"
      end
    end
    
  end
end    