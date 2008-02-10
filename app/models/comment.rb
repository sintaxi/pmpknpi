class Comment < ActiveRecord::Base
  
  belongs_to :article
  
  before_save :textilize_body
  
  def textilize_body
    self.body ||= ""
    self.body_html = self.body
    textilized = RedCloth.new(self.body_html)
    self.body_html = textilized.to_html
  end
  
  def mod(direction, user_info)
    case direction
    when "up"
      mod_up(user_info)
    when "down"
      mod_down(user_info)
    end
  end
  
  def mods_up_array
    @users_up_array ||= self.mods_up.split(',')
  end
  
  def mods_down_array
    @users_down_array ||= self.mods_down.split(',')
  end
  
  def moded_up?(user_info)
    return (self.mods_up.nil?) ? false : mods_up_array.split(',').include?(user_info)
  end
  
  def moded_down?(user_info)
    return (self.mods_down.nil?) ? false : mods_down_array.split(',').include?(user_info)
  end
  
  #these methods need to be refactored badly!
  
  def mod_up(user_info)
    if self.mods_up.nil?
      self.mods_up = user_info
    else
      users = self.mods_up.split(',')
      unless users.include?(user_info)
        users = users.push(user_info)
        self.mods_up = users.join(",")
      end
    end
    unless self.mods_down.nil?
      down_users = self.mods_down.split(",")
      down_users = down_users.delete_if{|x| x == user_info}
      self.mods_down = down_users.join(',')
    end
    self.mods_count = self.mods_up.split(',').length - self.mods_down.split(',').length
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