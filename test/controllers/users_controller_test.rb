require "test_helper"

describe UsersController do
  describe "logged in user" do
    it "creates a vote if there is a logged in user" do
      perform_login
      
      @work = Work.all.first
      
      expect { post work_upvote_path(@work.id) }.must_change "Vote.count", 1
    end
  end
  
  describe "no logged in user" do
    it "won't create a vote if there is no logged in user" do
      @work = Work.all.first
      
      expect { post work_upvote_path(@work.id) }.wont_change "Vote.count", 1   
    end
  end
end
