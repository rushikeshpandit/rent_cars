defmodule RentCarsWeb.Api.CategoryController do
  use RentCarsWeb, :controller
  alias RentCars.Categories
  alias RentCarsWeb.Router.Helpers, as: Routes
  action_fallback RentCarsWeb.Api.FallbackController

  def index(conn, _params) do
    categories = Categories.list_categories()
    render(conn, :index, categories: categories)
  end

  def create(conn, %{"category" => category}) do
    with {:ok, category} <- Categories.create_category(category) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_category_path(conn, :show, category))
      |> render(:show, category: category)
    end
  end

  def show(conn, %{"id" => id}) do
    category = Categories.get_category(id)
    render(conn, :show, category: category)
  end
end
