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
  
  def request=(request)
    self.user_ip    = request.remote_ip
    self.user_agent = request.env['HTTP_USER_AGENT']
    self.referrer   = request.env['HTTP_REFERER']
  end
  
  def website_submitted?
    !self.website.blank?
  end
  
  def user_data
    @user_data ||= "#{user_ip}--#{user_agent.gsub(',', ';')}"
  end
  
  def yay_array
    @yay_array ||= self.yay.split(',')
  end
  
  def nay_array
    @nay_array ||= self.nay.split(',')
  end
  
  def voted_yay?(user = self.user_data)
    yay_array.include?(user)
  end
  
  def voted_nay?(user = self.user_data)
    nay_array.include?(user)
  end
  
  def calculate_votes
    self.vote_count = yay_array.length - nay_array.length
  end
  
  def vote(direction, user_data)
    self.send("vote_#{direction}", user_data)
  end
  
  def vote_yay(voter_data)
    self.yay = yay_array.push(voter_data).join(",") unless voted_yay?(voter_data)
    self.nay = nay_array.delete_if{|x| x == voter_data}.join(",")
    calculate_votes
  end
  
  def vote_nay(voter_data)
    self.nay = nay_array.push(voter_data).join(",") unless voted_nay?(voter_data)
    self.yay = yay_array.delete_if{|x| x == voter_data}.join(",")
    calculate_votes
  end
  
end