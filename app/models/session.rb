class Session < ActiveRecord::Base
  belongs_to :user
  
  def self.find_by_session_id(session_id) 
    find(:first,:conditions => ["session_id = ?", session_id]) 
  end 

  def self.find_by_pass_session_id(session_id)
    find(:first,:conditions => ["pass_session_id = ?", session_id])
  end
  
end 