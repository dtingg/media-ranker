require "test_helper"

describe Work do
  let (:new_work) { Work.new(category: "album", title: "Lover", creator: "Taylor Swift", publication_year: 2019, description: "pop") }
  
  describe "initialize" do
    it "can be instantiated" do
      expect(new_work.valid?).must_equal true
    end
    
    it "will have the required fields" do
      work = works(:blue)
      
      [:category, :title, :creator, :publication_year, :description].each do |field|
        expect(work).must_respond_to field
      end
    end
  end
  
  describe "relationships" do
    it "can have many votes" do
      work = works(:goodbye)
      
      work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
      
      expect(work.votes.count).must_equal 2
    end
  end
  
  describe "validations" do
    it "must have a category that is album, book, or movie" do
      new_work.category = "cat"
      new_work.save
      
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :category
      expect(new_work.errors.messages[:category]).must_equal ["is not included in the list"]
    end
    
    it "must have a title" do
      new_work.title = nil
      new_work.save
      
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :title
      expect(new_work.errors.messages[:title]).must_equal ["can't be blank"]
    end
    
    it "must have a unique title for that category" do
      duplicate_work = Work.create(category: "book", title: "Hello Town")
      
      expect(duplicate_work.valid?).must_equal false
      expect(duplicate_work.errors.messages).must_include :title
      expect(duplicate_work.errors.messages[:title]).must_equal ["has already been taken"]
    end
    
    it "can have the same title as a work from another category" do
      same_title_work = Work.create(category: "movie", title: "Hello Town")
      
      expect(same_title_work.valid?).must_equal true
    end  
  end
  
  describe "sort_by_votes method" do
    it "returns all works sorted by votes descending" do
      sorted_works = Work.sort_by_votes
      
      expect(sorted_works.length).must_equal 16
      expect(sorted_works[0].votes.count).must_equal 4
      expect(sorted_works[1].votes.count).must_equal 3
      expect(sorted_works.last.votes.count).must_equal 0
    end
  end
  
  describe "top_ten method" do
    it "will only return 10 items, even if there are more than 10 objects in that category" do
      number_of_albums = Work.where(category: "album")
      expect(number_of_albums.length).must_equal 11
      
      top_albums = Work.top_ten("album")
      expect(top_albums.length).must_equal 10
      
      top_albums.each do |album|
        expect(album).must_be_instance_of Work
      end
    end
    
    it "will return less than 10 items if there are less than 10 objects in that category" do
      number_of_books = Work.where(category: "book")
      expect(number_of_books.length).must_equal 5
      
      top_books = Work.top_ten("book")
      expect(top_books.length).must_equal 5
      
      top_books.each do |book|
        expect(book).must_be_instance_of Work
      end
    end
    
    it "will return an empty array if there are 0 objects in that category" do
      number_of_movies = Work.where(category: "movie")
      expect(number_of_movies.length).must_equal 0
      
      top_movies = Work.top_ten("movie")
      expect(top_movies).must_equal []
    end
    
    it "will return items sorted by the number of votes" do
      top_books = Work.top_ten("book")
      
      expect(top_books[0].votes.length).must_equal 4
      expect(top_books[1].votes.length).must_equal 3
      expect(top_books[2].votes.length).must_equal 2
      expect(top_books[3].votes.length).must_equal 1
      expect(top_books[4].votes.length).must_equal 0
    end
  end
  
  describe "spotlight method" do
    it "correctly returns the highest rated work" do
      spotlight = Work.spotlight
      
      expect(spotlight).must_be_instance_of Work
      expect(spotlight.votes.count).must_equal 4
      expect(spotlight.title).must_equal works(:green).title
    end
  end
end
