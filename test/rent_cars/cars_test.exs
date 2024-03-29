defmodule RentCars.CarsTest do
  use RentCars.DataCase
  alias RentCars.Cars
  import RentCars.CategoriesFixtures
  import RentCars.CarsFixtures

  test "create car with success" do
    category = category_fixture()

    payload = %{
      name: "Honda City",
      description: "Good car",
      brand: "Honda",
      daily_rate: 100,
      license_plate: "MH12 RK8440",
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

    assert {:ok, car} = Cars.create(payload)
    assert car.name == payload.name
    assert car.description == payload.description
    assert car.brand == payload.brand
    assert car.daily_rate == payload.daily_rate
    assert car.license_plate == String.upcase(payload.license_plate)
    assert car.fine_amount == Money.new(payload.fine_amount)

    Enum.each(
      car.specifications,
      fn specification ->
        assert specification.name in Enum.map(payload.specifications, & &1.name)
        assert specification.description in Enum.map(payload.specifications, & &1.description)
      end
    )
  end

  test "update a car with success" do
    car = car_fixture()
    payload = %{name: "Lancer 2023"}
    assert {:ok, car} = Cars.update(car.id, payload)
    assert car.name == payload.name
  end

  test "throw error when try updating the licence_plate" do
    car = car_fixture()
    payload = %{license_plate: "update license_plate"}
    assert {:error, changeset} = Cars.update(car.id, payload)
    assert "you can`t update license_plate" in errors_on(changeset).license_plate
  end

  test "list all available cars" do
    category = category_fixture()
    car_fixture(%{category_id: category.id})
    car_fixture(%{category_id: category.id, name: "pumpkin"})
    car_fixture(%{available: false, category_id: category.id})

    assert Cars.list_cars() |> Enum.count() == 2

    assert Cars.list_cars(name: "pump") |> Enum.count() == 1
  end

  test "list cars by brand" do
    category = category_fixture()
    car_fixture(%{category_id: category.id, brand: "pumpkin"})
    car_fixture(%{category_id: category.id, name: "pumpkin"})

    assert Cars.list_cars(brand: "pum") |> Enum.count() == 1
  end

  test "list cars by category" do
    category = category_fixture(%{name: "pumpkin"})
    car_fixture(%{brand: "pumpkin"})
    car_fixture(%{category_id: category.id, name: "pumpkin"})

    assert Cars.list_cars(category: "pum") |> Enum.count() == 1
  end

  test "create car images" do
    car = car_fixture(%{brand: "pumpkin"})

    images = [
      %{
        image: %Plug.Upload{
          content_type: "image/jpg",
          filename: "car_1.jpg",
          path: "test/support/fixtures/car_1.jpg"
        }
      },
      %{
        image: %Plug.Upload{
          content_type: "image/jpg",
          filename: "car_2.jpg",
          path: "test/support/fixtures/car_2.jpg"
        }
      },
      %{
        image: %Plug.Upload{
          content_type: "image/jpg",
          filename: "car_3.jpg",
          path: "test/support/fixtures/car_3.jpg"
        }
      }
    ]

    {:ok, %{images: images_result}} = Cars.create_images(car.id, images)

    assert images_result
           |> Enum.map(& &1.image.file_name) ==
             [
               "car_1.jpg",
               "car_2.jpg",
               "car_3.jpg"
             ]
  end
end
