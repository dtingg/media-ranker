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
end