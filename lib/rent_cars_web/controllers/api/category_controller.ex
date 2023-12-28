defmodule RentCarsWeb.Api.CategoryController do
  use RentCarsWeb, :controller

  def index(conn, _params) do
    categories = %{
      data: [
        %{id: "123123", name: "SPORT", description: "petrol car"}
      ]
    }

    conn
    |> put_view(json: categories)

  end
end
