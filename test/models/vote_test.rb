require "test_helper"

describe Vote do
  let (:new_user) { User.create(username: "Dianna", joined: "15 Oct 2019") }
  let (:new_work) { Work.create(category: "album", title: "Lover", creator: "Taylor Swift", publication_year: 2019, description: "pop") }
  let (:new_vote) { Vote.new(user_id: new_user.id, work_id: new_work.id, created: "10 Oct 2019") }
  
  describe "initialize" do
    it "can be instantiated" do
      expect(new_vote.valid?).must_equal true
    end
    
    it "will have the required fields" do
      vote = votes(:one)
      
      [:user_id, :work_id, :created].each do |field|
        expect(vote).must_respond_to field
      end
    end
  end
  
  describe "relationships" do
    it "has a user object" do
      vote = votes(:one)
      
      expect(vote.user).must_be_instance_of User
      expect(vote.user.username).must_equal "Dianna"      
    end
    
    it "has a work object" do
      vote = votes(:two)
      
      expect(vote.work).must_be_instance_of Work
      expect(vote.work.title).must_equal "Goodbye Utopia"
    end
  end
  
  describe "validations" do
    it "must have a user_id" do
      vote = votes(:three)
      
      expect(vote.user_id).must_equal users(:brian).id
    end
    
    it "votes for the same work must have unique user_ids" do
      fake_vote = Vote.create(user_id: users(:greg).id, work_id: works(:goodbye).id, created: "10 Sep 2019")
      
      expect(fake_vote.valid?).must_equal false
      expect(fake_vote.errors.messages).must_include :user_id
      expect(fake_vote.errors.messages[:user_id]).must_equal ["user: has already voted for this work"]
    end
    
    it "must have a work_id" do
      new_vote.work_id = nil
      new_vote.save
      
      expect(new_vote.valid?).must_equal false
      expect(new_vote.errors.messages).must_include :work_id
      expect(new_vote.errors.messages[:work_id]).must_equal ["can't be blank"]
    end
    
    it "must have a created date" do
      new_vote.created = nil
      new_vote.save
      
      expect(new_vote.valid?).must_equal false
      expect(new_vote.errors.messages).must_include :created
      expect(new_vote.errors.messages[:created]).must_equal ["can't be blank"]
    end
  end  
  
  describe "exists? method" do
    it "returns true if a vote already exists" do
      test_work = works(:wake)
      test_user = users(:greg)
      test_vote = Vote.create(user_id: test_user.id, work_id: test_work.id, created: Date.today)
      
      result = Vote.exists?(test_work.id, test_user.id)
      
      expect(result).must_equal true
    end
    
    it "returns false if a vote doens't exist" do
      test_work = Work.create(category: "album", title: "Lover", creator: "Taylor Swift", publication_year: 2019, description: "pop") 
      test_user = users(:dianna)
      
      result = Vote.exists?(test_work.id, test_user.id)
      
      expect(result).must_equal false
    end
  end
  
  def self.exists?(work_id, user_id)
    result = Vote.where(work_id: work_id, user_id: user_id)  
    
    return false if result.empty?
    return true
  end
end
