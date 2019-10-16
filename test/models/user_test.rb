require "test_helper"

describe User do
  let (:new_user) { User.new(username: "Dianna", joined: "15 Oct 2019") }
  
  describe "initialize" do
    it "can be instantiated" do
      expect(new_user.valid?).must_equal true
    end
    
    it "will have the required fields" do
      user = users(:dianna)
      
      [:username, :joined].each do |field|
        expect(user).must_respond_to field
      end
    end
  end
  
  describe "relationships" do
    it "can have many votes" do
      user = users(:brian)
      
      user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
      
      expect(user.votes.count).must_equal 2
    end
  end
  
  describe "validations" do
    it "must a username" do
      new_user.username = nil
      new_user.save
      
      expect(new_user.valid?).must_equal false
      expect(new_user.errors.messages).must_include :username
      expect(new_user.errors.messages[:username]).must_equal ["can't be blank"]
    end
    
    it "must have a joined date" do
      new_user.joined = nil
      new_user.save
      
      expect(new_user.valid?).must_equal false
      expect(new_user.errors.messages).must_include :joined
      expect(new_user.errors.messages[:joined]).must_equal ["can't be blank"]      
    end
  end
end
