# this helper is available in controllers and views
module GlobalMixin
  
  def viewer_data
    @viewer_data ||= "#{request.remote_ip}--#{request.env["HTTP_USER_AGENT"].gsub(',', ';')}"
  end
  
  # def web_authentication
  #   redirect '/login' unless admin?
  # end
  # 
  # def authorize
  #   unless admin?
  #     redirect '/'
  #     false
  #   end
  # end

  # def admin?
  #   session[:password] == SETTINGS[:password]
  # end

end