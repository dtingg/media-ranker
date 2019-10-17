class User < ApplicationRecord
  has_many :votes, dependent: :destroy
  
  validates :username, presence: true
  validates :joined, presence: true
end
