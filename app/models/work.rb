class Work < ApplicationRecord
  has_many :votes, dependent: :nullify
  
  validates_inclusion_of :category, in: ["album", "book", "movie"]
  validates :title, presence: true, uniqueness: true
  
  def self.top_ten(category)
    top_ten = Work.where(category: category).sample(10)
    return top_ten
  end
  
  def self.spotlight
    spotlight = Work.all.sample(1)
    return spotlight[0]
  end
end
