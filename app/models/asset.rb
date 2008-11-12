class Asset < ActiveRecord::Base
  
  # Plugins
  has_attachment :storage => :file_system, 
    :thumbnails => { 
      :ver => '300x500>', 
      :hor => '500x300>',
      :large => '300x300', 
      :med => '160x160!', 
      :small => '75x75!', 
      :thumb => '50x50!' 
      }, 
    :max_size => 5.megabytes,
    :path_prefix => "public/uploads/assets",
    :content_type => :image
  
  # Validations
  validates_as_attachment
  
end