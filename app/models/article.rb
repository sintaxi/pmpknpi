class Article < ActiveRecord::Base
  
  # ASSOCIATIONS
  has_many :comments
  
  # VALIDATIONS
  validates_presence_of :title
  validates_uniqueness_of :title
  
  # CALLBACKS
  before_save :create_permalink
  before_save :draft_check
  
  # PLUGINS
  merb_can_filter :body, :excerpt
  
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
  
  # BEFORES
  def create_permalink
    self.permalink = self.title.gsub(/\W+/, ' ').strip.downcase.gsub(/\ +/, '-') if permalink.blank?
  end
  
  def draft_check
    self.published_at = nil if self.draft.to_s == "1"
  end
  
end