class User < ApplicationRecord
  has_many :votes, dependent: :destroy
  
  validates :username, presence: true
  validates :joined, presence: true
  
  def sorted_votes
    votes = self.votes
    
    sorted_votes = votes.sort_by do |vote|
      vote.work.title
    end
    
    return sorted_votes
  end
end
