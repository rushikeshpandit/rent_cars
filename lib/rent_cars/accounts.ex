defmodule RentCars.Accounts do
  alias RentCars.Accounts.User
  alias RentCars.Repo

  def create_user(attrs) do
    attrs
    |> User.changeset()
    |> Repo.insert()
  end

  def update_user(user, params) do
    user
    |> User.update_user(params)
    |> Repo.update()
  end

  def get_user(id) do
    Repo.get(User, id)
  end
end
