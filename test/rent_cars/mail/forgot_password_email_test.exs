defmodule RentCars.Mail.ForgotPasswordEmailTest do
  use RentCars.DataCase
  alias RentCars.Mail.ForgotPasswordEmail
  import Swoosh.TestAssertions
  import RentCars.UserFixtures

  test "send email to reset password" do
    user = user_fixture()
    token = "afknealfneq"
    email_expected = ForgotPasswordEmail.create_email(user, token)
    assert email_expected.to == [{"rushikesh", user.email}]
    assert_email_not_sent(email_expected)
  end

  test "sent email to reset password" do
    user = user_fixture()
    token = "afknealfneq"
    ForgotPasswordEmail.send_forgot_password_email(user, token)
    assert {:email, email_result} = assert_email_sent()
    assert [{user.first_name, user.email}] == email_result.to
  end
end
