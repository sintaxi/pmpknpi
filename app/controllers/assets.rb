class Assets < Application
  provides :xml, :yaml, :js
  
  before :login_required
  before :layout
  
  def index
    @assets = Asset.find :all, :conditions => "parent_id IS NULL", :order => "created_at DESC"
    @asset = Asset.new(params[:asset])
    display @assets
  end

  def show
    @asset = Asset.find(params[:id])
    raise NotFound unless @asset
    display @asset
  end

  def new
    only_provides :html
    @asset = Asset.new(params[:asset])
    render
  end

  def create
    @asset = Asset.new(params[:asset])
    if @asset.save
      redirect url(:assets)
    else
      render :new
    end
  end

  def edit
    only_provides :html
    @asset = Asset.find_by_id(params[:id])
    raise NotFound unless @asset
    render
  end

  def update
    @asset = Asset.find_by_id(params[:id])
    raise NotFound unless @asset
    if @asset.update_attributes(params[:asset])
      redirect url(:asset, @asset)
    else
      raise BadRequest
    end
  end

  def destroy
    @asset = Asset.find_by_id(params[:id])
    raise NotFound unless @asset
    if @asset.destroy
      redirect url(:assets)
    else
      raise BadRequest
    end
  end
  
  private
  
  def layout
    self._layout = :admin
  end
  
end
