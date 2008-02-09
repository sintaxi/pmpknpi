class Sessions < Application
  
  def new
    render
  end
  
  def create
    session[:password] = params[:password]
    redirect '/'
    if admin?
      redirect '/articles/'
    end
  end
  
  def destroy
    session[:password] = nil
    redirect '/'
  end
  
end