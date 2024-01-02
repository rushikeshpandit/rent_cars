defmodule RentCars.AccountsTest do
  use RentCars.DataCase
  alias RentCars.Accounts

  describe "create user" do
    test "creat_user/1 with valid data" do
      valid_attrs = %{
        first_name: "rushikesh",
        last_name: "pandit",
        user_name: "rushikeshpandit",
        password: "Rushi@7588",
        password_confirmation: "Rushi@7588",
        email: "rushikesh.d.pandit@gmail.com",
        drive_license: "123456"
      }

      assert {:ok, user} = Accounts.create_user(valid_attrs)

      assert user.first_name == valid_attrs.first_name
      assert user.last_name == valid_attrs.last_name
      assert user.user_name == valid_attrs.user_name
      assert user.email == valid_attrs.email
      assert user.drive_license == valid_attrs.drive_license
    end
  end
end
