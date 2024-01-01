defmodule RentCarsWeb.Api.CategoryJSON do
  # If you want to customize a particular status code,
  # you may add your own clauses, such as:
  #
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def render(:index, %{categories: categories}) do
    %{
      data:
        Enum.map(
          categories,
          &%{
            id: &1.id,
            name: &1.name,
            description: &1.description
          }
        )
    }
  end
end
