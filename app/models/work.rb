class Work < ApplicationRecord
  validates_inclusion_of :category, in: ["album", "book", "movie"]
  validates :title, presence: true, uniqueness: true
end
