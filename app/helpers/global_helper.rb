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
    
    # MONKEY PATCH!
    # def checkbox_field(attrs = {}, hidden_attrs={})
    #   boolbox = true
    #   boolbox = false if ( attrs.has_key?(:boolean) and !attrs[:boolean] )
    #   attrs.delete(:boolean)
    # 
    #   if( boolbox )
    #           on            = attrs.delete(:on)  || 1
    #           off           = attrs.delete(:off) || 0
    #         # attrs[:value] = on if ( (v = attrs[:value]).nil? || v != "" )
    #           attrs[:value] = on if ( (v = attrs[:value]).nil? || v != "1" )
    #   else
    #           # HTML-escape the value attribute
    #           attrs[:value] = escape_xml( attrs[:value] )
    #   end
    # 
    #   attrs.merge!(:type => :checkbox)
    #   attrs.add_html_class!("checkbox")
    #   (boolbox ? hidden_field({:name => attrs[:name], :value => off}.merge(hidden_attrs)) : '') + optional_label(attrs){self_closing_tag("input", attrs)}
    # end
    
  end
end    