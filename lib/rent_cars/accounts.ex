defmodule RentCars.Accounts do
  alias RentCars.Accounts.User
  alias RentCars.Repo

  def create_user(attrs) do
    attrs
    |> User.changeset()
    |> Repo.insert()
  end

  def update_user(user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def get_user(id) do
    Repo.get(User, id)
  end

  def delete_user(user) do
    Repo.delete(user)
  end
end
