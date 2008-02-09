module GlobalMixin
  
  def web_authentication
    redirect '/login' unless admin?
  end

  def authorize
    unless admin?
      redirect '/'
      false
    end
  end

  def admin?
    session[:password] == SETTINGS[:password]
  end

end