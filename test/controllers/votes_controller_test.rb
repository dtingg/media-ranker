require "test_helper"

describe VotesController do
  describe "no logged in user" do
    it "won't create a vote if there is no logged in user" do
      @work = Work.all.first
      
      expect { post work_upvote_path(@work.id) }.wont_change "Vote.count"
      expect(flash[:warning]).must_equal "A problem occurred: You must log in to do that"      
      
      must_respond_with :redirect
    end
  end
  
  describe "logged in user" do
    it "won't let a user vote for the same work twice" do
      perform_login
      
      @work = Work.all.first
      post work_upvote_path(@work.id) 
      
      expect { post work_upvote_path(@work.id) }.wont_change "Vote.count"
      expect(flash[:warning]).must_equal "A problem occurred: Could not upvote."
      expect(flash[:error]).must_equal "user: has already voted for this work"
      
      must_respond_with :redirect
    end
    
    it "creates a vote if there is a logged in user" do
      perform_login
      
      @work = Work.all.first
      
      expect { post work_upvote_path(@work.id) }.must_change "Vote.count", 1
      expect(flash[:success]).must_equal "Successfully upvoted!"
      
      must_respond_with :redirect
    end
  end
end
