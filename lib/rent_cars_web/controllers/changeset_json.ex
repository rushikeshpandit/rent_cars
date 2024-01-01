defmodule RentCarsWeb.ChangesetJSON do
  use RentCarsWeb, :html

  def error(%{changeset: changeset}) do
    errors = Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
    %{errors: errors}
  end
end
