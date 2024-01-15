defmodule RentCarsWeb.Api.Admin.CarJSON do
  alias RentCars.Cars.Car
  alias RentCars.Cars.CarPhoto
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
      fine_amount: Money.to_string(car.fine_amount),
      category_id: car.category_id,
      specifications: load_specifications(car.specifications),
      images: load_images(car),
      name: car.name,
      available: car.available
    }
  end

  defp load_specifications(specifications) do
    if Ecto.assoc_loaded?(specifications) do
      SpecificationJSON.index(%{specifications: specifications})
    else
      nil
    end
  end

  defp load_images(%{images: images} = car) do
    if Ecto.assoc_loaded?(car.images) do
      Enum.map(images, &CarPhoto.url({&1.image, &1}))
    else
      []
    end
  end
end
