class Sessions < Application
  
  def new
    render
  end
  
  def create
    session[:password] = params[:password]
    redirect '/'
    if authorized?
      redirect_back_or_default('/articles')
    end
  end
  
  def destroy
    session[:password] = nil
    redirect '/'
  end
  
end