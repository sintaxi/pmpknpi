class Comments < Application
  provides :xml, :js, :yaml
  
  before :login_required
  before :layout, :exclude => :update
  
  def index
    @comments = Comment.find(:all, :include => :article)
    render
  end
  
  def create
    @article = Article.find_by_param(params[:article_id])
    @comment = Comment.new(params[:comment].merge(:article => @article))
    @comment.request = request
    @comment.yay = @comment.user_data
    if @comment.save 
      redirect "/articles/#{@article.to_param}"
    else
      render :template => "articles/show.html"
    end
  end
  
  def update
    @article = Article.find_by_param(params[:article_id])
    @comment = Comment.find(params[:id])
    @comment.vote(params[:vote], viewer_data)
    @saved = @comment.save
    if content_type == :html
      redirect "/articles/#{@article.to_param}"
    else
      render
    end
  end
  
  private
  
  def layout
    if authorized?
      self._layout = :admin
    else 
      self._layout = :application
    end
  end

end