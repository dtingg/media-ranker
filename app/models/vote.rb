class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work
  
  validates :user_id, presence: true, uniqueness: { scope: :work_id, message: "user: has already voted for this work" }
  validates :work_id, presence: true
  validates :created, presence: true 
  
  def self.exists?(work_id, user_id)
    result = Vote.where(work_id: work_id, user_id: user_id)  
    
    return false if result.empty?
    return true
  end
end
