defmodule RentCarsWeb.Api.SessionJSON do
  alias RentCarsWeb.Api.UserJSON
  # If you want to customize a particular status code,
  # you may add your own clauses, such as:
  #
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".

  def show(%{session: session}) do
    %{data: data(session)}
  end

  def data(session) do
    %{
      token: session.token,
      user: UserJSON.show(%{user: session.user})
    }
  end
end
