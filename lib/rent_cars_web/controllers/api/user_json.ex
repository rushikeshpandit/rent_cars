defmodule RentCarsWeb.Api.UserJSON do
  alias RentCars.Accounts.Avatar
  alias RentCars.Accounts.User
  # If you want to customize a particular status code,
  # you may add your own clauses, such as:
  #
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".

  def show(%{user: user}) do
    %{data: data(user)}
  end

  def data(%User{} = user) do
    %{
      id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      user_name: user.user_name,
      email: user.email,
      drive_license: user.drive_license,
      role: user.role,
      avatar: Avatar.url({user.avatar, user}),
      inserted_at: user.inserted_at,
      updated_at: user.updated_at
    }
  end
end
