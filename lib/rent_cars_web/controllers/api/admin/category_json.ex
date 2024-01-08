defmodule RentCarsWeb.Api.Admin.CategoryJSON do
  alias RentCars.Categories.Category
  # If you want to customize a particular status code,
  # you may add your own clauses, such as:
  #
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".

  def index(%{categories: categories}) do
    %{
      data: Enum.map(categories, &data/1)
    }
  end

  def show(%{category: category}) do
    %{data: data(category)}
  end

  def data(%Category{} = category) do
    %{
      id: category.id,
      name: category.name,
      description: category.description,
      inserted_at: category.inserted_at,
      updated_at: category.updated_at
    }
  end
end
