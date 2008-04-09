# this helper is available in controllers and views
module GlobalMixin
  
  def viewer_data
    @viewer_data ||= "#{request.remote_ip}--#{request.env["HTTP_USER_AGENT"].gsub(',', ';')}"
  end
  
  def utc_to_local(time, offset=SETTINGS["timezone_offset"])
    time + (offset *3600)
  end
  
  def local_to_utc(time, offset =SETTINGS["timezone_offset"])
    time + (offset *-1 *3600)
  end

end