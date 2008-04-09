class Article < ActiveRecord::Base
  include GlobalMixin
  
  # ASSOCIATIONS
  has_many :comments, :dependent => :destroy
  
  # VALIDATIONS
  validates_presence_of :title
  validates_uniqueness_of :title
  
  # CALLBACKS
  before_save :create_permalink
  before_save :draft_check
  after_validation :convert_to_utc
  
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
      with_scope({:find => { :conditions => ['published_at <= ? AND published_at IS NOT NULL', Time.now.utc] } }, &block)
    end
  end
  
  def convert_to_utc
    self.published_at = local_to_utc(published_at) if published_at
  end
  
  def create_permalink
    self.permalink = self.title.gsub(/\W+/, ' ').strip.downcase.gsub(/\ +/, '-') if permalink.blank?
  end
  
  def draft_check
    self.published_at = nil if self.draft.to_s == "1"
  end
  
end