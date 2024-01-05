defmodule RentCars.Sessions.SendForgotPasswordToEmailTest do
  use RentCars.DataCase
  alias RentCars.Sessions.SendForgotPasswordToEmail
  import RentCars.UserFixtures

  test "send email to reset password" do
    user = user_fixture()

    assert {:ok, returned_user, _token} = SendForgotPasswordToEmail.execute(user.email)
    assert user.email == returned_user.email
  end

  test "throw error when user does not exists" do
    assert {:error, message} = SendForgotPasswordToEmail.execute("somewrongemail&gmail.com")
    assert "User does not exists" == message
  end
end
