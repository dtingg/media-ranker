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
end   







#   describe "show" do
#     it "responds with success when showing an existing valid driver" do
#       #Act
#       get driver_path(driver_fred.id)

#       # Assert
#       must_respond_with :success
#     end

#     it "redirects to drivers path if given invalid driver id" do
#       # Arrange
#       invalid_id = -1

#       # Act
#       get driver_path(invalid_id)

#       # Assert
#       must_redirect_to drivers_path
#     end
#   end

#   describe "new" do
#     it "responds with success" do
#       # Act
#       get new_driver_path

#       # Assert
#       must_respond_with :success
#     end
#   end

#   describe "create" do
#     it "can create a new driver with valid information accurately, and redirect" do
#       # Arrange
#       driver_hash = { driver: { name: "Barney Rubble", vin: "456", car_make: "bird", car_model: "robin", available: false } }

#       # Act-Assert
#       expect { post drivers_path, params: driver_hash }.must_change "Driver.count", 1

#       # Assert
#       new_driver = Driver.find_by(name: driver_hash[:driver][:name])

#       expect(new_driver.vin).must_equal driver_hash[:driver][:vin]
#       expect(new_driver.car_make).must_equal driver_hash[:driver][:car_make]
#       expect(new_driver.car_model).must_equal driver_hash[:driver][:car_model]
#       expect(new_driver.available).must_equal driver_hash[:driver][:available]

#       must_respond_with :redirect
#     end

#     it "does not create a driver if the form data violates Driver validations, and responds with success" do
#       # Arrange
#       driver_hash = { driver: { name: "Dino" } }

#       # Act-Assert
#       expect { post drivers_path, params: driver_hash }.wont_change "Driver.count"

#       # Assert
#       must_respond_with :success
#     end  
#   end

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
