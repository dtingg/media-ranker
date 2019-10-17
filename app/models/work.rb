class Work < ApplicationRecord
  has_many :votes, dependent: :destroy
  # has_many :votes, dependent: :nullify
  
  validates_inclusion_of :category, in: ["album", "book", "movie"]
  validates :title, presence: true, uniqueness: { scope: :category }
  
  def self.sort_by_votes
    # https://stackoverflow.com/questions/16996618/rails-order-by-results-count-of-has-many-association
    sorted_works = Work.left_joins(:votes).group(:id).order(Arel.sql('COUNT(votes.id) DESC'))
    
    return sorted_works
  end
  
  def self.top_ten(category)
    category_works = Work.sort_by_votes.where(category: category)
    
    top_works = category_works.limit(10)
    
    return top_works
  end
  
  def self.spotlight
    all_works = Work.sort_by_votes
    
    spotlight = all_works[0]
    
    return spotlight
  end
end
