class Article < ActiveRecord::Base
  
  # ASSOCIATIONS
  has_many :comments
  
  # VALIDATIONS
  validates_presence_of :title
  validates_uniqueness_of :title
  
  # CALLBACKS
  before_save :create_permalink
  before_save :filter_content
  before_save :draft_check
  
  # PLUGINS
  acts_as_sanitizer
  
  # ACCESSORS
  attr_accessor :draft
  
  def to_param
    permalink
  end
  
  # FINDS
  class << self
    def find_by_param(*args)
      find_by_permalink *args
    end
    
    def with_published(&block)
      with_scope({:find => { :conditions => ['published_at <= ? AND published_at IS NOT NULL', Time.now] } }, &block)
    end
  end
  
  # BEFORE
  def create_permalink
    self.permalink = self.title.gsub(/\W+/, ' ').strip.downcase.gsub(/\ +/, '-') if permalink.blank?
  end
  
  def filter_content
    self.body ||= ""
    self.body_html = sanitize(self.body, self.filter)
    self.excerpt ||= ""
    self.excerpt_html = sanitize(self.excerpt, self.filter)
  end
  
  def draft_check
    self.published_at = nil if self.draft.to_s == "1"
  end
  
end