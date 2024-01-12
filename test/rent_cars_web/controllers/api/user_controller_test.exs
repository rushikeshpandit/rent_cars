defmodule RentCarsWeb.Api.AccountControllerTest do
  use RentCarsWeb.ConnCase
  import RentCars.UserFixtures
  setup :include_normal_user_token

  test "create user when data is valid", %{conn: conn} do
    attrs = user_attrs()
    conn = post(conn, Routes.api_user_path(conn, :create, user: attrs))
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get(conn, Routes.api_user_path(conn, :show, id))
    email = String.downcase(attrs.email)

    assert %{
             "id" => ^id,
             "email" => ^email
           } = json_response(conn, 200)["data"]
  end

  test "upload user image", %{conn: conn, user: _user} do
    photo = %Plug.Upload{
      content_type: "image/jpg",
      filename: "1.jpg",
      path: "test/support/fixtures/1.jpg"
    }

    conn = patch(conn, Routes.api_user_path(conn, :upload_photo), avatar: photo)

    assert json_response(conn, 201)["data"]["avatar"] |> String.contains?("1.jpg")
  end
end
