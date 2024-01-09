defmodule RentCars.CarsFixtures do
  alias RentCars.Cars
  import RentCars.CategoriesFixtures

  def car_attrs(attrs \\ %{}) do
    category = category_fixture()

    valid_attrs =
      %{
        name: "Honda City",
        description: "Good car",
        brand: "Honda",
        daily_rate: 100,
        license_plate: "adfdf #{:rand.uniform(10_000)}",
        fine_amount: 30,
        category_id: category.id,
        specifications: [
          %{
            name: "wheels",
            description: "4 wheels"
          },
          %{
            name: "steering",
            description: "electric"
          },
          %{
            name: "navigation",
            description: "navigation included"
          },
          %{
            name: "cruze control",
            description: "cruze control included"
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
