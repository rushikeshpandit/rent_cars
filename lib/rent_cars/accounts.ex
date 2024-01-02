defmodule RentCars.Accounts do
  alias RentCars.Repo
  alias RentCars.Accounts.User

  def create_user(attrs) do
    attrs
    |> User.changeset()
    |> Repo.insert()
  end
end
