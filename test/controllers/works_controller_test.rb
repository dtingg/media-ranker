require "test_helper"

describe WorksController do
  describe "index" do
    it "responds with success when there is at least one work saved" do
      expect(Work.count > 0).must_equal true
      
      get works_path
      
      must_respond_with :success 
    end
    
    it "responds with success when there are no works saved" do
      Work.all.each do |work|
        work.destroy
      end
      
      expect(Work.count).must_equal 0
      
      get works_path
      
      must_respond_with :success
    end    
  end
  
  describe "show" do
    it "responds with success when showing an existing valid work" do
      test_work = works(:heart)
      
      get work_path(test_work.id)
      
      must_respond_with :success
    end
    
    it "redirects to works path if given invalid work id" do
      invalid_id = -1
      
      get work_path(invalid_id)
      
      must_redirect_to works_path
    end
  end  
  
  describe "new" do
    it "responds with success" do
      get new_work_path
      
      must_respond_with :success
    end
  end
  
  describe "create" do
    it "does not create a work if the form data is nil, and responds with redirect" do
      work_hash = { work: nil }
      
      expect { post works_path, params: work_hash }.wont_change "Work.count"
      
      must_respond_with :redirect
    end  
    
    it "can create a new work with valid information accurately, and redirect" do
      work_hash = { work: { category: "album", title: "Lover", creator: "Taylor Swift", publication_year: 2019, description: "Pop"} }
      
      expect { post works_path, params: work_hash }.must_change "Work.count", 1
      
      new_work = Work.find_by(title: work_hash[:work][:title])
      
      expect(new_work.category).must_equal work_hash[:work][:category]
      expect(new_work.creator).must_equal work_hash[:work][:creator]
      expect(new_work.publication_year).must_equal work_hash[:work][:publication_year]
      expect(new_work.description).must_equal work_hash[:work][:description]
      
      expect(flash[:success]).must_equal "Successfully created #{new_work.category} #{new_work.id}"
      must_respond_with :redirect
    end
    
    it "will not create a new work if a required field is missing" do
      work_hash = { work: { category: "album", title: nil, creator: "Taylor Swift", publication_year: 2019, description: "Pop"} }
      
      expect { post works_path, params: work_hash }.wont_change "Work.count", 1
      expect(flash[:warning]).must_equal "A problem occurred: Could not create album"
    end
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid work" do
      test_work = works(:heart)
      
      get edit_work_path(test_work.id)
      
      must_respond_with :success
    end
    
    it "responds with redirect when getting the edit page for a non-existing driver" do
      invalid_id = -1
      
      get edit_work_path(invalid_id)
      
      must_respond_with :redirect
    end
  end
  
  describe "update" do    
    it "can update an existing work with valid information accurately, and redirect" do
      test_work = works(:summer)
      old_category = test_work.category
      
      changes_hash = { work: { category: "movie", title: "Summer Select 2", creator: "Sammy Ortiz", publication_year: 2019, description: "Sequel" }}
      
      expect { patch work_path(test_work.id), params: changes_hash }.wont_change "Work.count"
      
      updated_work = Work.find_by(id: test_work.id)
      
      expect(updated_work.category).must_equal changes_hash[:work][:category]
      expect(updated_work.title).must_equal changes_hash[:work][:title]
      expect(updated_work.creator).must_equal changes_hash[:work][:creator]
      expect(updated_work.publication_year).must_equal changes_hash[:work][:publication_year]
      expect(updated_work.description).must_equal changes_hash[:work][:description]
      
      expect(flash[:success]).must_equal "Successfully updated #{old_category} #{test_work.id}"
      must_respond_with :redirect      
    end
  end
  
  describe "destroy" do
    it "destroys the work instance in db when work exists, then redirects" do
      test_work = works(:heart)
      
      expect{ delete work_path(test_work.id)}.must_differ "Work.count", -1
      
      expect(flash[:success] = "Successfully destroyed #{test_work.category} #{test_work.id}")
      must_respond_with :redirect
    end
    
    it "does not change the db when the work does not exist, then responds with redirect" do  
      invalid_id = -1
      
      expect{ delete work_path(invalid_id)}.wont_change "Work.count"
      
      must_respond_with :redirect
    end
  end  
end
