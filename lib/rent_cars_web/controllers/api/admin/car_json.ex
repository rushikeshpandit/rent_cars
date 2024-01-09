defmodule RentCarsWeb.Api.Admin.CarJSON do
  alias RentCars.Cars.Car
  alias RentCarsWeb.Api.Admin.SpecificationJSON
  # If you want to customize a particular status code,
  # you may add your own clauses, such as:
  #
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".

  def show(%{car: car}) do
    %{data: data(car)}
  end

  def data(%Car{} = car) do
    %{
      id: car.id,
      description: car.description,
      brand: car.brand,
      daily_rate: car.daily_rate,
      license_plate: car.license_plate,
      fine_amount: car.fine_amount,
      category_id: car.category_id,
      specifications: load_specifications(car.specifications),
      name: car.name
    }
  end

  defp load_specifications(specifications) do
    if Ecto.assoc_loaded?(specifications) do
      SpecificationJSON.index(specifications)
    else
      nil
    end
  end
end
