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
  def render("index.json", %{categories: categories}) do
    %{data: many_category(categories)}
  end

  defp many_category(categories) when is_list(categories) do
    Enum.reduce(categories, [], fn elem, acc ->
      [render("category.json", %{category: elem}) | acc]
    end)
  end

  defp many_category(_categories), do: []
end
