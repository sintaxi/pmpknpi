class Sessions < Application
  
  def new
    render
  end
  
  def create
    session[:password] = params[:password]
    if authorized?
      redirect '/'
      #redirect_back_or_default('/articles')
    else
      redirect '/'
    end
  end
  
  def destroy
    session[:password] = nil
    redirect '/'
  end
  
end