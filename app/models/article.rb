class Article < ActiveRecord::Base

  has_many :comments
  
  validates_presence_of :title
  validates_uniqueness_of :title
  
  before_validation :create_permalink
  before_save :filter_content
  before_save :draft_check
  
  #attr_accessor :draft
  
  def to_param
    permalink
  end
  
  def self.find_by_param(*args)
    find_by_permalink *args
  end
  
  def create_permalink
    self.permalink = self.title.gsub(/\W+/, ' ').strip.downcase.gsub(/\ +/, '-') if permalink.blank?
  end
  
  def filter_content
    self.body ||= ""
    self.body_html = sanitize(self.body, self.filter)
    self.excerpt ||= ""
    self.excerpt_html = sanitize(self.excerpt, self.filter)
  end
  
  def draft
    true if published_at.nil? && !new_record?
  end
  
  def draft_check
    self.published_at = nil if self.draft == "1"
  end
  
end