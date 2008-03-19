class Articles < Application
  provides :xml, :js, :yaml, :rss
  
  #before :login_required, :exclude => [:index, :show]
  #before :basic_authentication, :exclude => [:index, :show]
  
  before :layout
  before :articles
  
  def index
    display @articles
  end

  def show
    @article = Article.find_by_param(params[:id], :include => :comments)
    raise NotFound unless @article
    @comment = Comment.new(params[:comment])
    display @article
  end
  
  def new
    only_provides :html
    @article = Article.new(params[:article])
    render
  end

  def create
    @article = Article.new(params[:article])
    if @article.save
      redirect url(:article)
    else
      render :new
    end
  end

  def edit
    only_provides :html
    @article = Article.find_by_param(params[:id])
    raise NotFound unless @article
    render
  end

  def update
    @article = Article.find_by_param(params[:id])
    if @article.update_attributes(params[:article])
      redirect "/articles/#{@article.to_param}"
    else
      #raise BadRequest
      render :edit
    end
  end

  def destroy
    @article = Article.find_by_param(params[:id])
    raise NotFound unless @article
    if @article.destroy
      redirect "/articles"
    else
      raise BadRequest
    end
  end
  
  private
  
  def layout    
    #if authorized? or admin_action? 
      #self._layout = :admin 
    #else 
      self._layout = :application
    #end
  end
  
  def admin_action?
    ['edit', 'new'].include? params[:action]
  end
  
end