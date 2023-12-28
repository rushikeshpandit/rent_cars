defmodule RentCarsWeb.Api.CategoryControllerTest do
  use RentCarsWeb.ConnCase

  test "list all categories", %{conn: conn} do
    conn = get(conn, Routes.api_category_path(conn, :index))

    assert json_response(conn, 200)["data"] == [
             %{
               "description" => "petrol car",
               "id" => "123123",
               "name" => "SPORT"
             }
           ]
  end
end
