class Work < ApplicationRecord
  has_many :votes, dependent: :nullify
  
  validates_inclusion_of :category, in: ["album", "book", "movie"]
  validates :title, presence: true, uniqueness: { scope: :category }
  
  def self.top_ten(category)
    category_works = Work.where(category: category).order(:title)
    
    top_works = category_works.max_by(10) do |work|
      work.votes.count
    end    
    
    return top_works
  end
  
  def self.spotlight
    all_works = Work.order(:title)
    
    spotlight = all_works.max_by do |work|
      work.votes.count
    end
    
    return spotlight
  end
end
