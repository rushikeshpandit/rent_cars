defmodule RentCars.Rentals.CreateRental do
  alias RentCars.Cars.Car
  alias RentCars.Repo

  def execute(car_id) do
    is_car_available?(car_id)
  end

  defp is_car_available?(car_id) do
    Car
    |> Repo.get(car_id)
    |> check_car_availability()
  end

  defp check_car_availability(%{available: false}), do: {:error, "Car is unavailable"}

  defp check_car_availability(car), do: {:ok, car}
end
