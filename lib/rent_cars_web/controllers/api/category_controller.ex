defmodule RentCarsWeb.Api.CategoryController do
  use RentCarsWeb, :controller

  def index(conn, _params) do
    conn
    |> json(%{
      data: [
        %{id: "123123", name: "SPOT", description: "petrol car"}
      ]
    })
  end
end
