defmodule RentCarsWeb.Api.UserController do
  use RentCarsWeb, :controller
  alias RentCars.Accounts
  alias RentCarsWeb.Router.Helpers, as: Routes
  action_fallback RentCarsWeb.FallbackController

  def create(conn, %{"user" => user}) do
    with {:ok, user} <- Accounts.create_user(user) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_user_path(conn, :show, user))
      |> render(:show, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, :show, user: user)
  end

  def upload_photo(conn, %{"avatar" => params}) do
    [user_id] = get_req_header(conn, "user_id")

    with {:ok, user} <- Accounts.upload_photo(user_id, params) do
      conn
      |> put_status(:created)
      |> render(:show, user: user)
    end
  end

  # def update(conn, %{"id" => id, "user" => user_params}) do
  #   user = Accounts.get_user(id)

  #   with {:ok, user} <- Accounts.update_user(user, user_params) do
  #     render(conn, :show, user: user)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   user = Accounts.get_user(id)

  #   with {:ok, _user} <- Accounts.delete_user(user) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end
end
