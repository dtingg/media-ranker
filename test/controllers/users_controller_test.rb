require "test_helper"

describe UsersController do
  describe "index" do
    it "responds with success when there is at least one user saved" do
      expect(User.count > 0).must_equal true
      
      get users_path
      
      must_respond_with :success      
    end
    
    it "responds with success when there are no users saved" do
      User.all.each do |user|
        user.destroy
      end
      
      expect(User.count).must_equal 0
      
      get users_path
      
      must_respond_with :success
    end
  end    
  describe "show" do
    it "responds with success when showing an existing valid user" do
      test_user = User.first
      
      get user_path(test_user.id)
      
      must_respond_with :success
    end
    
    it "redirects to users path if given invalid user id" do
      invalid_id = -1
      
      get user_path(invalid_id)
      
      must_redirect_to users_path
    end
  end  
  
  describe "login form" do
    it "responds with success" do
      get login_path
      
      must_respond_with :success
    end
  end
  
  describe "login for new user" do
    it "creates a new user and flashes a message" do
      login_data = { user: { username: "Lewis" }}
      
      expect {post login_path, params: login_data }.must_change "User.count", 1
      
      new_user = User.find_by(username: "Lewis")
      
      expect(flash[:success]).must_equal "Successfully created new user Lewis with ID #{new_user.id}"
    end
  end  
end
