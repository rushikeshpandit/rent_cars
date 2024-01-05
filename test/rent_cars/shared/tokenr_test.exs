defmodule RentCars.Shared.TokenrTest do
  use RentCars.DataCase

  alias RentCars.Shared.Tokenr
  import RentCars.UserFixtures

  test "create auth token" do
    user = user_fixture()
    token = Tokenr.generate_auth_token(user)
    {:ok, returned_user} = Tokenr.verify_auth_token(token)

    assert user == returned_user
  end

  test "create forgot email token" do
    user = user_fixture()
    token = Tokenr.generate_forgot_email_token(user)
    {:ok, returned_user} = Tokenr.verify_forgot_email_token(token)

    assert user == returned_user
  end
end
