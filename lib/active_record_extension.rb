module Sintaxi
  module ActsAsSanitizer
    
    def self.included(base)
      base.extend ActMethods
    end
    
    module ActMethods
      def acts_as_sanitizer
        unless included_modules.include? InstanceMethods
          include InstanceMethods
        end
      end
    end
    
    module InstanceMethods
      def sanitize(text, filter="Plain HTML")
        textilized = case filter
          when "Markdown" then sanitize_code(BlueCloth.new(text)).to_html
          when "Textile" then sanitize_code(RedCloth.new(text).to_html)
          else sanitize_code(text.dup)
          end
      end

      def sanitize_code(text)
        text.scan(/(<code\:([a-z].+?)>(.+?)<\/code>)/m).each do |match|
          text.gsub!(match[0],CodeRay.scan(match[2], match[1].to_sym).div(:css => :class))
        end
        text
      end
    end
    
  end    
end

ActiveRecord::Base.send :include, Sintaxi::ActsAsSanitizer