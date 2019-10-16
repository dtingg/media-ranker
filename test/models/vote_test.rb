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
      vote = votes(:vote_one)
      
      [:user_id, :work_id, :created].each do |field|
        expect(vote).must_respond_to field
      end
    end
    
    
  end
end
