def sanitize_text(text, sanitizer=SETTINGS[:sanitizer])
  textilized = case sanitizer
    when "markaby" then format_code(BlueCloth.new(text))
    when "textile" then format_code(RedCloth.new(text))
    else
      format_code(text)
    end
end

def format_code(textilized)
  textilized.scan(/(<code\:([a-z].+?)>(.+?)<\/code>)/m).each do |match|
    textilized.gsub!(match[0],CodeRay.scan(match[2], match[1].to_sym).div(:css => :class))
  end
  textilized.to_html
end