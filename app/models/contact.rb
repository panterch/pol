class Contact < ActiveRecord::Base
  
  validates_presence_of :from, :body
  
  after_create :deliver
  
protected
  def deliver
    Mailer.deliver_contact self
  end
  
end
