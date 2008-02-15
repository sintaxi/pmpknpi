class ActiveRecord::Base
  def filter(text, sanitizer="None")
    textilized = case sanitizer
      when "Markdown" then filter_code(BlueCloth.new(text)).to_html
      when "Textile" then filter_code(RedCloth.new(text).to_html)
      else filter_code(text.dup)
      end
  end

  def filter_code(text)
    text.scan(/(<code\:([a-z].+?)>(.+?)<\/code>)/m).each do |match|
      text.gsub!(match[0],CodeRay.scan(match[2], match[1].to_sym).div(:css => :class))
    end
    text
  end
end

