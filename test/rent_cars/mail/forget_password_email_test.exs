defmodule RentCars.Mail.ForgotPasswordEmailTest do
  use RentCars.DataCase
  alias RentCars.Mail.ForgotPasswordEmail
  import RentCars.UserFixtures

  test "send email to reset password" do
    user = user_fixture()
    token = "afknealfneq"
    email_expected = ForgotPasswordEmail.create_email(user, token)
    assert email_expected.to == [{"Rushikesh Pandit", "rushikesh.d.pandit@gmail.com"}]
  end
end
