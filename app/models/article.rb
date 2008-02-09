class Article < ActiveRecord::Base

  has_many :comments
  
  validates_presence_of :title, :body
  before_save :create_permalink
  before_save :format_content
  
  def to_param
    permalink
  end
  
  def self.find_by_param(*args)
    find_by_permalink *args
  end
  
  def create_permalink
    self.permalink = self.title.gsub(/\W+/, ' ').strip.downcase.gsub(/\ +/, '-') if permalink.blank?
  end
  
  def format_content
    text = self.body ||= ""
    self.body_html = sanitize_text(text)
    
    text = self.intro ||= ""
    self.intro_html = sanitize_text(text)
  end
  
end