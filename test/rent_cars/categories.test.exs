defmodule RentCars.CategoriesTest do
  use RentCars.DataCase
  alias RentCars.Categories
  alias RentCars.Categories.Category

  test "list_categories/0 returns all categories" do
    assert Categories.list_categories() == []
  end

  test "create_category/1 with valid data" do
    attrs = %{description: "Car with high ground clearence", name: "SUV"}
    assert {:ok, %Category{} = category} = Categories.create_category(attrs)
    assert category.name == attrs.name
    assert category.description == attrs.description
  end

  test "create_category/1 with valid data and duplicated name" do
    attrs = %{description: "Car with high ground clearence", name: "SUV"}
    Categories.create_category(attrs)

    assert {:error, changeset} = Categories.create_category(attrs)
    assert "has already been taken" in errors_on(changeset).name
  end

  test "create_category/1 with valid data without description" do
    attrs = %{name: "SUV"}

    assert {:error, changeset} = Categories.create_category(attrs)
    assert "can't be blank" in errors_on(changeset).description
    assert %{description: ["can't be blank"]} = errors_on(changeset)
  end

  test "get_category/1 with valid data without description" do
    attrs = %{description: "Car with high ground clearence", name: "SUV"}
    %{:ok, category} = Categories.create_category(attrs)

    assert Categories.get_category(category.id) == category
  end

  test "update_category/2" do
    attrs = %{description: "Car with high ground clearence", name: "SUV"}
    %{:ok, category} = Categories.create_category(attrs)

    %{:ok, updated_category} = Categories.update_category(category, %{name: "truck"})

    assert updated_category.name == "truck"
  end

  test "delete_category/1" do
    attrs = %{description: "Car with high ground clearence", name: "SUV"}
    %{:ok, category} = Categories.create_category(attrs)

    %{:ok, %Category{}} = Categories.delete_category(category)

    assert updated_category.name == "truck"
  end
end
