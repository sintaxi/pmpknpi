# This file was taken from MrBlog
module AuthenticatedSystem
  protected

  # check if user is logged in
  def logged_in?
    authorized?
  end

  # Check if the user is authorized.
  def authorized?
    session[:password] == SETTINGS[:password]
  end

  # Filter method to enforce a login requirement.
  def login_required
    return true if logged_in?
    store_location
    access_denied and return false
  end

  # Redirect as appropriate when an access request fails.
  def access_denied
    redirect '/login'
  end  

  # Store the URI of the current request in the session.
  def store_location
    session[:return_to] = request.uri
  end

  # Redirect to the saved URI or default
  def redirect_back_or_default(default)
    redirect(session[:return_to] || default)
    session[:return_to] = nil
  end

end
