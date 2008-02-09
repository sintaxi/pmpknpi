class Articles < Application
  provides :xml, :js, :yaml, :rss
  
  #before :basic_authentication, :exclude => [:index, :show]
  
  before :layout
  before :articles
  
  def index
    render @articles
  end

  def show
    @article = Article.find_by_param(params[:id])
    @comment = Comment.new(params[:comment])
    render @article
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
      render :action => :new
    end
  end

  def edit
    only_provides :html
    @article = Article.find_by_param(params[:id])
    render
  end

  def update
    @article = Article.find_by_param(params[:id])
    if @article.update_attributes(params[:article])
      redirect url(:article)
    else
      raise BadRequest
    end
  end

  def destroy
    @article = Article.find_by_param(params[:id])
    if @article.destroy
      redirect url(:articles)
    else
      raise BadRequest
    end
  end
  
  private
  
  def layout    
    if admin? or admin_action? 
      self._layout = :admin 
    else 
      self._layout = :application
    end
  end
  
  def admin_action?
    ['edit', 'new'].include? params[:action]
  end
end