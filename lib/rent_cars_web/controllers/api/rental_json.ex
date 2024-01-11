defmodule RentCarsWeb.Api.RentalJSON do
  alias RentCarsWeb.Api.Admin.CarJSON
  alias RentCars.Rentals.Rental
  # If you want to customize a particular status code,
  # you may add your own clauses, such as:
  #
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".

  def show(%{rental: rental}) do
    %{data: data(rental)}
  end

  def data(%Rental{} = rental) do
    %{
      id: rental.id,
      start_date: rental.start_date,
      end_date: rental.end_date,
      expected_return_date: rental.expected_return_date,
      car: load_car(rental.car, rental.car_id),
      user_id: rental.user_id,
      inserted_at: rental.inserted_at,
      updated_at: rental.updated_at
    }
  end

  defp load_car(car, car_id) do
    if Ecto.assoc_loaded?(car) do
      CarJSON.show(%{car: car})
    else
      %{id: car_id}
    end
  end
end
