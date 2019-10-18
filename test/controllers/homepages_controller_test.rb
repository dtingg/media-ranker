require "test_helper"

describe HomepagesController do
  it "can get the homepage" do
    get root_path
    
    must_respond_with :success
  end
  
  it "can get the homepage if there are no works" do
    Work.all.each do |work|
      work.destroy
    end
    
    expect(Work.count).must_equal 0
    
    get root_path
    
    must_respond_with :success
  end
end
