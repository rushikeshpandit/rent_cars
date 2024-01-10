defmodule RentCars.CarsFixtures do
  alias RentCars.Cars
  import RentCars.CategoriesFixtures

  def car_attrs(attrs \\ %{}) do
    category_id = Map.get(attrs, :category_id) || category_fixture().id
    random_number = :rand.uniform(10_000)

    valid_attrs = %{
      name: "Lancer #{random_number}",
      description: "good car",
      brand: "Mitsubishi",
      daily_rate: 100,
      license_plate: "adfdf #{random_number}",
      fine_amount: 30,
      category_id: category_id,
      specifications: [
        %{
          name: "wheels #{random_number}",
          description: "pumpkin"
        },
        %{
          name: "pumpkin wheels #{random_number}",
          description: "1323"
        }
      ]
    }

    Enum.into(attrs, valid_attrs)
  end

  def car_fixture(attrs \\ %{}) do
    {:ok, car} =
      attrs
      |> car_attrs()
      |> Cars.create()

    car
  end
end
