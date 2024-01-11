defmodule RentCars.Rentals.CreateRentalTest do
  use RentCars.DataCase
  import RentCars.CarsFixtures
  alias RentCars.Rentals.CreateRental

  describe "create rentals" do
    test "throw error when car is not available" do
      car = car_fixture(%{available: false})
      assert {:error, "Car is unavailable"} == CreateRental.execute(car.id)
    end
  end
end
