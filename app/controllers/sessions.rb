class Sessions < Application
  
  def new
    render
  end
  
  def create
    session[:password] = params[:password]
    redirect '/'
    
    ### NOT WORKING PROPERLY
    ### seems to be a problem with clearing sessions
    ### in the redirect_back_or_default method.
    #
    # if authorized?
    #   redirect_back_or_default('/articles')
    # else
    #   redirect '/'
    # end
  end
  
  def destroy
    session[:password] = nil
    redirect '/'
  end
  
end