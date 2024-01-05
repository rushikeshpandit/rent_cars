defmodule RentCarsWeb.Api.SesionsControllerTest do
  use RentCarsWeb.ConnCase

  describe "handle with session" do
    setup :include_normal_user_token

    test "create session", %{conn: conn, user: user, password: password} do
      conn =
        post(
          conn,
          Routes.api_session_path(conn, :create, email: user.email, password: password)
        )

      assert json_response(conn, 201)["data"]["user"]["data"]["email"] == user.email
    end

    test "get me", %{conn: conn, user: user, token: token} do
      conn =
        post(
          conn,
          Routes.api_session_path(conn, :me, token: token)
        )

      assert json_response(conn, 200)["data"]["user"]["data"]["email"] == user.email
    end

    test "reset password", %{conn: conn, user: user} do
      conn =
        post(
          conn,
          Routes.api_session_path(conn, :reset_password, email: user.email)
        )

      assert json_response(conn, 204) == ""
    end
  end
end
