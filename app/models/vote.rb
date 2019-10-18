class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work
  
  validates :user_id, presence: true, uniqueness: { scope: :work_id, message: "user: has already voted for this work" }
  validates :work_id, presence: true
  validates :created, presence: true 
end
