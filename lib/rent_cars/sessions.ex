defmodule RentCars.Sessions do
  alias RentCars.Accounts.User
  alias RentCars.Repo
  alias RentCars.Shared.Tokenr
  @error_invalid_credentials {:error, "Email or password is incorrect"}

  def me(token) do
    Tokenr.verify_auth_token(token)
  end

  def create(email, password) do
    User
    |> Repo.get_by(email: email)
    |> check_if_user_exists()
    |> validate_password(password)
  end

  def check_if_user_exists(nil), do: @error_invalid_credentials
  def check_if_user_exists(user), do: user

  defp validate_password({:error, _} = err, _password), do: err

  defp validate_password(user, password) do
    if Argon2.verify_pass(password, user.password_hash) do
      token = Tokenr.generate_auth_token(user)
      {:ok, user, token}
    else
      @error_invalid_credentials
    end
  end
end
