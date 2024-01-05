defmodule RentCars.Shared.Tokenr do
  alias Phoenix.Token
  @context RentCarsWeb.Endpoint
  @login_token_salt "login_user_token"
  @forgot_email_token_salt "forgot_email_user_token"
  @max_age 86_400
  def generate_auth_token(user) do
    Token.sign(@context, @login_token_salt, user)
  end

  def verify_auth_token(token) do
    Token.verify(@context, @login_token_salt, token, max_age: @max_age)
  end

  def generate_forgot_email_token(user) do
    Token.sign(@context, @forgot_email_token_salt, user)
  end

  def verify_forgot_email_token(token) do
    Token.verify(@context, @forgot_email_token_salt, token, max_age: @max_age)
  end
end
