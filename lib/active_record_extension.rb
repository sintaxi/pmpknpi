class ActiveRecord::Base
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


module Merb
  module Helpers
    module DateAndTime

      
    end
  end
end
