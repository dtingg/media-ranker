class User < ApplicationRecord
  # has_many :votes, dependent: :nullify
  
  validates :username, presence: true
end
