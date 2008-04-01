class Comment < ActiveRecord::Base
  
  belongs_to :article, 
    :counter_cache => true
  
  validates_presence_of :article_id, :name, :email, :body
  
  validates_format_of :email, 
    :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  
  validates_format_of :website, 
    :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix,
    :if => :website_submitted?
  
  merb_can_filter :body
  
  def filter
    "Textile"
  end
  
  def website_submitted?
    !self.website.blank?
  end
  
  def mod(direction, user_info)
    self.send("mod_#{direction}", user_info)
  end
  
  def up_array
    @up_array ||= self.mods_up.split(',')
  end
  
  def down_array
    @down_array ||= self.mods_down.split(',')
  end
  
  def moded_up?(user_info)
    return (self.mods_up.nil?) ? false : up_array.split(',').include?(user_info)
  end
  
  def moded_down?(user_info)
    return (self.mods_down.nil?) ? false : down_array.split(',').include?(user_info)
  end
  
  #these methods need to be refactored badly!
  
  # def mod_up(user_info)
  #   if self.mods_up.nil?
  #     self.mods_up = user_info
  #   else
  #     users = self.mods_up.split(',')
  #     unless users.include?(user_info)
  #       users = users.push(user_info)
  #       self.mods_up = users.join(",")
  #     end
  #   end
  #   unless self.mods_down.nil?
  #     down_users = self.mods_down.split(",")
  #     down_users = down_users.delete_if{|x| x == user_info}
  #     self.mods_down = down_users.join(',')
  #   end
  #   self.mods_count = self.mods_up.split(',').length - self.mods_down.split(',').length
  # end
  
  def mod_up(user_info)
    if self.mods_up.nil?
      self.mods_up = user_info
    else
      unless moded_up? user_info
        up_array = up_array.push(user_info)
        self.mods_up = up_array.join(",")
      end
    end
    unless moded_down? user_info
      down_array = down_array.delete_if{|x| x == user_info}
      self.mods_down = down_users.join(',')
    end
    self.mods_count = up_array.length - down_array.length
  end
  
  def mod_down(user_info)
    if self.mods_down.nil?
      self.mods_down = user_info
    else
      users = self.mods_down.split(',')
      unless users.include?(user_info)
        users = users.push(user_info)
        self.mods_down = users.join(",")
      end
    end
    unless self.mods_up.nil?
      up_users = self.mods_up.split(',')
      up_users = up_users.delete_if{|x| x == user_info}
      self.mods_up = up_users.join(",")
    end
    self.mods_count = self.mods_up.split(',').length - self.mods_down.split(',').length
  end
  
end