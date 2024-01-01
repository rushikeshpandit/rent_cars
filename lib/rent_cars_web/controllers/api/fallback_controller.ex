defmodule RentCarsWeb.Api.FallbackController do
  use RentCarsWeb, :controller
  alias RentCarsWeb.ChangesetJSON

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ChangesetJSON)
    |> render(:error, changeset: changeset)
  end
end
