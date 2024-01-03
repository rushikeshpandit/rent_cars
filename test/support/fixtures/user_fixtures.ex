defmodule RentCars.UserFixtures do
  alias RentCars.Accounts

  def user_attrs(attrs \\ %{}) do
    valid_attrs =
      %{
        first_name: "rushikesh",
        last_name: "pandit",
        user_name: "rushikeshpandit",
        password: "Rushi@7588",
        password_confirmation: "Rushi@7588",
        email: "RUSHIKESH.d.pandit@gmail.com",
        drive_license: "123456"
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
end
