# this helper is available in controllers and views
module GlobalMixin
  
  def viewer_data
    @viewer_data ||= "#{request.remote_ip}--#{request.env["HTTP_USER_AGENT"].gsub(',', ';')}"
  end

end