defmodule RentCars.Sessions.SendForgotPasswordToEmail do
  alias RentCars.Accounts.User
  alias RentCars.Mail.ForgotPasswordEmail
  alias RentCars.Repo
  alias RentCars.Shared.Tokenr

  def execute(email) do
    User
    |> Repo.get_by(email: email)
    |> prepare_response()
  end

  defp prepare_response(nil), do: {:error, "User does not exists"}

  defp prepare_response(user) do
    token = Tokenr.generate_forgot_email_token(user)
    Task.async(fn -> ForgotPasswordEmail.send_forgot_password_email(user, token) end)
    {:ok, user, token}
  end
end
