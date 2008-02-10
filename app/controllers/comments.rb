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
    @comment.author = @comment.mods_up = "#{request.remote_ip}--#{request.env["HTTP_USER_AGENT"]}"
    
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
    @comment.mod(params[:mod], "#{request.remote_ip}--#{request.env["HTTP_USER_AGENT"]}")
    @saved = @comment.save
    render
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