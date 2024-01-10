defmodule RentCarsWeb.Api.CarControllerTest do
  use RentCarsWeb.ConnCase
  import RentCars.CarsFixtures

  describe "list cars" do
    test "list all available cars", %{conn: conn} do
      car_fixture()
      car_fixture(%{brand: "Pumpkin"})

      conn = get(conn, Routes.api_car_path(conn, :index, %{brand: "Pumpkin"}))
      car_returend = json_response(conn, 200)["data"] |> hd

      assert "Pumpkin" = car_returend["brand"]
    end
  end
end
