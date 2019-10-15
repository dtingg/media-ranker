require "test_helper"

describe Work do
  let (:new_work) { Work.new(category: "album", title: "Lover", creator: "Taylor Swift", publication_year: 2019, description: "pop") }
  
  describe "initialize" do
    it "can be instantiated" do
      expect(new_work.valid?).must_equal true
    end
    
    it "will have the required fields" do
      new_work.save      
      work = Work.first
      
      [:category, :title, :creator, :publication_year, :description].each do |field|
        expect(work).must_respond_to field
      end
    end
  end
  
  describe "relationships" do
    it "can have many votes" do
      # TODO
    end
  end
  
  describe "validations" do
    it "must have a category" do
      new_work.category = nil
      new_work.save
      
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :category
      expect(new_work.errors.messages[:category]).must_equal ["is not included in the list"]
    end
    
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
    
    it "must have a unique title" do
      new_work.save
      
      work2 = Work.create(category: "album", title: "Lover")
      
      expect(work2.valid?).must_equal false
      expect(work2.errors.messages).must_include :title
      expect(work2.errors.messages[:title]).must_equal ["has already been taken"]
    end
  end
  
  describe "custom methods" do
    it "can return the top ten for a category" do
      # TODO
    end
    
    it "can return the top work for the spotlight" do
      # TODO
    end
  end
end
