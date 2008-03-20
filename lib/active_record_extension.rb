## MONKEY PATCH

class Object
  def try(method)
    send method if respond_to? method
  end
end

###
### This is now a Plugin 'sudo gem install merb_can_filter'
###

# module Sintaxi
#   module MerbFilter
#     
#     def self.included(base)
#       base.extend ActMethods
#     end
#     
#     module ActMethods
#       def merb_can_filter(*columns)
#         unless included_modules.include? InstanceMethods
#           include InstanceMethods
#           class_inheritable_accessor :unfiltered
#           before_save :filter_columns
#         end
#         self.unfiltered ||= columns ||= []    
#       end
#     end
#     
#     module InstanceMethods
#       def filter_columns
#         unfiltered.each do |column|
#           send "#{column}_html=", sanitize(send(column).to_s.dup, self.filter)
#         end
#       end
#     
#       def sanitize(text, filter="Plain HTML")
#         textilized = case filter
#           when "Markdown" then sanitize_code(BlueCloth.new(text)).to_html
#           when "Textile" then sanitize_code(RedCloth.new(text).to_html)
#           else sanitize_code(text.dup)
#           end
#       end
# 
#       def sanitize_code(text)
#         text.scan(/(<code\:([a-z].+?)>(.+?)<\/code>)/m).each do |match|
#           text.gsub!(match[0],CodeRay.scan(match[2], match[1].to_sym).div(:css => :class))
#         end
#         text
#       end
#     end
#     
#   end    
# end
# 
# ActiveRecord::Base.send :include, Sintaxi::MerbFilter if defined?(ActiveRecord::Base)