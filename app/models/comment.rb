class Comment < ActiveRecord::Base
  
  belongs_to :article
  
  before_save :textilize_body
  
  def textilize_body
    self.body ||= ""
    self.body_html = self.body
    textilized = RedCloth.new(self.body_html)
    self.body_html = textilized.to_html
  end
  
  def mod
    #...get user info
    #...get arrays
    #...remove from one list *if there
    #...insert into other *unless there
  end
  
end