defmodule RentCars.SessionsTest do
  use RentCars.DataCase

  alias RentCars.Sessions
  import RentCars.UserFixtures

  test "get user from token" do
    user = user_fixture()
    password = "Rushi@7588"
    assert {:ok, returned_user, token} = Sessions.create(user.email, password)

    assert {:ok, returned_user} == Sessions.me(token)
  end

  test "return authenticated user" do
    user = user_fixture()
    password = "Rushi@7588"
    assert {:ok, returned_user, _token} = Sessions.create(user.email, password)

    assert user.email == returned_user.email
  end

  test "throw error when wrong password entered" do
    user = user_fixture()
    password = "Rushi@1431431"
    assert {:error, message} = Sessions.create(user.email, password)

    assert "Email or password is incorrect" == message
  end

  test "throw error if user does not exists" do
    user = user_fixture()
    password = "Rushi@1431431"
    assert {:error, message} = Sessions.create(user.email, password)

    assert "Email or password is incorrect" == message
  end
end
