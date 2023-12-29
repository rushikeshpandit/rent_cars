defmodule RentCarsWeb.Api.CategoryController do
  use RentCarsWeb, :controller
  alias RentCars.Categories

  def index(conn, _params) do
    categories = Categories.list_categories()
    render(conn, :index, categories: categories)
  end

  def create(conn, %{"category" => category}) do
    {:ok, category} = Categories.create_category(category)

    conn
    |> put_status(:created)
    |> render(:show, category: category)
  end

  def show(conn, %{"id" => id}) do
    category = Categories.get_category(id)
    render(conn, :show, category: category)
  end
end
