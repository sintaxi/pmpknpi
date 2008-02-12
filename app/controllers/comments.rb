class Comments < Application
  provides :xml, :js, :yaml
  
  before :article
  
  def index
    @comments = Comment.find(:all)
    render @comments
  end
  
  def show
    @comment = Comment.find(params[:id])
    render @comment
  end
  
  def new
    only_provides :html
    @comment = Comment.new(params[:comment])
    render
  end
  
  def create
    @article = Article.find_by_param(params[:article_id])
    @comment = Comment.new(params[:comment])
    @comment.article = @article
    @comment.author = @comment.mods_up = viewer_data
    if @comment.save 
      redirect url(:article, @article)
    else 
      render :action => :new 
    end
  end
  
  def edit
    only_provides :html
    @comment = Comment.find(params[:id])
    render
  end
  
  def update
    @article = Article.find_by_param(params[:article_id])
    @comment = Comment.find(params[:id])
    @comment.mod(params[:mod], viewer_data)
    @saved = @comment.save
    if content_type == :html 
      redirect "/articles/#{@article.to_param}"
    else
      render
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect url(:comments)
    else
      raise BadRequest
    end
  end

end