class Asset < ActiveRecord::Base

  # Associations
  belongs_to :attachable, :polymorphic => true
  
  # Plugins
  # has_attachment :storage => :s3, 
  #   :thumbnails => { :large => '300x300!', :med => '160x160!', :small => '75x75!', :thumb => '50x50!', :tiny => '40x40!', :micro => '30x30!' }, 
  #   :max_size => 5.megabytes,
  #   :path_prefix => "image_assets",
  #   :content_type => :image
    
  has_attachment :storage => :file_system, 
    :thumbnails => { :large => '300x300!', :med => '160x160!', :small => '75x75!', :thumb => '50x50!', :tiny => '40x40!', :micro => '30x30!' }, 
    :max_size => 5.megabytes,
    :path_prefix => "public/uploads",
    :content_type => :image
  
  # Validations
  validates_as_attachment
  
end