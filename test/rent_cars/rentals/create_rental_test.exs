defmodule RentCars.Rentals.CreateRentalTest do
  use RentCars.DataCase
  import RentCars.CarsFixtures
  import RentCars.UserFixtures
  import RentCars.RentalsFixtures
  alias RentCars.Rentals.CreateRental

  describe "create rentals" do
    setup do
      car_available = car_fixture(%{available: true})
      car_unavailable = car_fixture(%{available: false})
      user = user_fixture()
      %{car_available: car_available, car_unavailable: car_unavailable, user: user}
    end

    test "throw error when car is not available", %{car_unavailable: car, user: user} do
      expected_return_date = create_expected_return_date()

      assert {:error, "Car is unavailable"} ==
               CreateRental.execute(car.id, expected_return_date, user.id)
    end

    test "throw error  data is before 24 hours", %{car_available: car, user: user} do
      expected_return_date =
        NaiveDateTime.utc_now()
        |> then(&%{&1 | hour: &1.hour + 2})
        |> NaiveDateTime.to_string()

      assert {:error, "Invalid return date"} ==
               CreateRental.execute(car.id, expected_return_date, user.id)
    end

    test "should throw error when user has booked a car", %{
      car_available: car_available,
      car_unavailable: car,
      user: user
    } do
      rental_fixture(%{car_id: car.id, user_id: user.id})

      expected_return_date = create_expected_return_date()

      assert {:error, "User has a reservation"} ==
               CreateRental.execute(car_available.id, expected_return_date, user.id)
    end

    test "book a car", %{car_available: car_available, user: user} do
      expected_return_date = create_expected_return_date()

      assert car_available.available

      {:ok, result} = CreateRental.execute(car_available.id, expected_return_date, user.id)

      %{rental: rental, set_car_unavailable: car_updated} = result
      assert car_updated.id == car_available.id
      refute car_updated.available
      assert rental.end_date == nil
      assert rental.car_id == car_available.id
      assert rental.user_id == user.id
      assert rental.total == nil
    end
  end

  defp create_expected_return_date do
    NaiveDateTime.utc_now()
    |> then(&%{&1 | month: &1.month + 1})
    |> NaiveDateTime.to_string()
  end
end
