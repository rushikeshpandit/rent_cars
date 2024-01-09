defmodule RentCars.UserFixtures do
  alias RentCars.Accounts

  def user_attrs(attrs \\ %{}) do
    valid_attrs = %{
      first_name: "rushikesh",
      last_name: "pandit",
      user_name: "rushikeshpandit#{:rand.uniform(10_000)}",
      password: "Rushi@7588",
      password_confirmation: "Rushi@7588",
      email: "rushikesh.d.pandit#{:rand.uniform(10_000)}@gmail.com",
      drive_license: "dr #{:rand.uniform(10_000)}"
    }

    Enum.into(attrs, valid_attrs)
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> user_attrs()
      |> Accounts.create_user()

    user
  end

  def admin_fixture(attrs \\ %{}) do
    {:ok, admin} =
      attrs
      |> user_attrs()
      |> Map.put(:role, "ADMIN")
      |> Accounts.create_user()

    admin
  end
end
