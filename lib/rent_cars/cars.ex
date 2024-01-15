defmodule RentCars.Cars do
  import Ecto.Query
  alias __MODULE__.Car
  alias RentCars.Repo

  def get_car!(id), do: Repo.get!(Car, id) |> Repo.preload([:specifications, :images])

  def create(attrs) do
    %Car{}
    |> Car.changeset(attrs)
    |> Repo.insert()
  end

  def update(car_id, attrs) do
    car_id
    |> get_car!()
    |> Car.update_changeset(attrs)
    |> Repo.update()
  end

  def list_cars(filter_params \\ []) do
    query = where(Car, [c], c.available == true)

    filter_params
    |> Enum.reduce(query, fn
      {:name, name}, query ->
        name = "%" <> name <> "%"
        where(query, [c], ilike(c.name, ^name))

      {:brand, brand}, query ->
        brand = "%" <> brand <> "%"
        where(query, [c], ilike(c.brand, ^brand))

      {:category, category}, query ->
        category = "%" <> category <> "%"

        query
        |> join(:inner, [c], ca in assoc(c, :category))
        |> where([_c, ca], ilike(ca.name, ^category))
    end)
    |> preload([:specifications, :images])
    |> Repo.all()
  end

  def create_images(id, images) do
    images = Enum.map(images, &Map.put(&1, :car_id, id))

    id
    |> get_car!()
    |> Repo.preload([:images])
    |> Car.changeset(%{images: images})
    |> Repo.update()
  end
end
