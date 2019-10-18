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
    it "responds with success when showing a valid user" do
      test_user = users(:greg)
      
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
    it "can log in an existing user and flashes a message" do
      login_data = { user: { username: "Dianna" }}
      
      expect {post login_path, params: login_data }.wont_change "User.count"
      
      existing_user = User.find_by(username: "Dianna")
      
      expect(session[:user_id]).must_equal existing_user.id
      expect(flash[:success]).must_equal "Successfully logged in as existing user #{existing_user.username}"
    end
    
    it "can create a new user and flashes a message" do
      login_data = { user: { username: "Lewis" }}
      
      expect {post login_path, params: login_data }.must_change "User.count", 1
      
      new_user = User.find_by(username: "Lewis")
      
      expect(session[:user_id]).must_equal new_user.id
      expect(flash[:success]).must_equal "Successfully created new user Lewis with ID #{new_user.id}"
    end
  end  
  
  describe "logout" do
    it "successfully logs a valid user out" do
      perform_login
      
      post logout_path
      
      assert_nil(session[:user_id])
      expect(flash[:success]).must_equal "Successfully logged out"
      must_redirect_to root_path
    end
    
    it "redirects to root path if no user is logged in" do
      post logout_path
      
      must_redirect_to root_path
    end
  end
end
