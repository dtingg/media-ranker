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
    
    
  end
  
end   


#   describe "edit" do
#     it "responds with success when getting the edit page for an existing, valid driver" do
#       # Act
#       get edit_driver_path(driver_fred.id)

#       # Assert
#       must_respond_with :success
#     end

#     it "responds with redirect when getting the edit page for a non-existing driver" do
#       # Arrange
#       invalid_id = -1

#       # Act
#       get edit_driver_path(invalid_id)

#       # Assert
#       must_respond_with :redirect
#     end
#   end

#   describe "update" do
#     it "can update an existing driver with valid information accurately, and redirect" do
#       # Arrange
#       original_driver = driver_fred
#       changes_hash = { driver: { name: "Wilma Flintstone", vin: "456", car_make: "bird", car_model: "robin", available: false } }

#       # Act-Assert
#       expect { patch driver_path(original_driver.id), params: changes_hash }.wont_change "Driver.count"

#       # Assert
#       updated_driver = Driver.find_by(id: original_driver.id)

#       expect(updated_driver.name).must_equal changes_hash[:driver][:name]
#       expect(updated_driver.vin).must_equal changes_hash[:driver][:vin]
#       expect(updated_driver.car_make).must_equal changes_hash[:driver][:car_make]
#       expect(updated_driver.car_model).must_equal changes_hash[:driver][:car_model]
#       expect(updated_driver.available).must_equal changes_hash[:driver][:available]

#       must_respond_with :redirect
#     end

#     it "does not update any driver if given an invalid id, and responds with a redirect" do
#       # Arrange
#       driver_hash = { driver: { name: "Wilma Flintstone", vin: "456", car_make: "bird", car_model: "robin", available: false }}
#       invalid_id = -1

#       # Act-Assert
#       expect { patch driver_path(invalid_id), params: driver_hash }.wont_change "Driver.count"

#       # Assert
#       must_redirect_to drivers_path
#     end

#     it "does not update a driver if the form data violates Driver validations" do
#       # Arrange
#       driver_fred.save
#       driver_hash = { driver: { name: nil } }

#       # Act-Assert
#       expect { patch driver_path(driver_fred.id), params: driver_hash }.wont_change "Driver.count"

#       # Assert
#       updated_driver = Driver.first
#       expect(updated_driver.name).must_equal driver_fred.name
#     end
#   end

#   describe "destroy" do
#     it "destroys the driver instance in db when driver exists, then redirects" do
#       # Arrange
#       driver_fred.save

#       # Act-Assert
#       expect{ delete driver_path(driver_fred.id)}.must_differ "Driver.count", -1

#       # Assert
#       must_respond_with :redirect
#     end

#     it "does not change the db when the driver does not exist, then responds with redirect" do
#       # Arrange
#       invalid_id = -1

#       # Act-Assert
#       expect{ delete driver_path(invalid_id)}.wont_change "Driver.count"

#       # Assert
#       must_respond_with :redirect
#     end
#   end

#   end
# end
