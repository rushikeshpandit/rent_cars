defmodule RentCars.CategoriesFixtures do
  alias RentCars.Categories

  def category_fixture(attrs \\ %{}) do
    random_number = :rand.uniform(10_000)

    {:ok, category} =
      attrs
      |> Enum.into(%{
        description: "some category description #{random_number}",
        name: "some category name #{random_number}"
      })
      |> Categories.create_category()

    category
  end
end
