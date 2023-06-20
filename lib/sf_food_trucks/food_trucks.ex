defmodule SfFoodTrucks.FoodTrucks do
  @moduledoc """
  The FoodTrucks context.
  """

  import Ecto.Query, warn: false
  alias SfFoodTrucks.Repo

  alias SfFoodTrucks.FoodTrucks.FoodTruck
  alias SfFoodTrucks.FoodTrucks.FoodTruckRating

  @doc """
  Returns the list of food_trucks.

  ## Examples

      iex> list_food_trucks()
      [%FoodTruck{}, ...]

  """
  def list_food_trucks do
    query =
      from ft in FoodTruck,
        left_join: r in subquery(ratings()),
        on: ft.id == r.food_truck_id,
        select_merge: %{avg_rating: r.avg_rating, total_ratings: r.total_ratings}

    Repo.all(query)
  end

  defp ratings() do
    from r in FoodTruckRating,
      select: %{
        food_truck_id: r.food_truck_id,
        avg_rating: avg(r.rating),
        total_ratings: count(r)
      },
      group_by: [r.food_truck_id, r.id]
  end

  @doc """
  Gets a single food_truck.

  Raises `Ecto.NoResultsError` if the Food truck does not exist.

  ## Examples

      iex> get_food_truck!(123)
      %FoodTruck{}

      iex> get_food_truck!(456)
      ** (Ecto.NoResultsError)

  """
  def get_food_truck!(id), do: Repo.get!(FoodTruck, id)

  def get_food_truck_rating(food_truck_id, user_id) do
    Repo.one(
      from r in FoodTruckRating,
        where:
          r.user_id == ^user_id and
            r.food_truck_id == ^food_truck_id
    )
    |> update_or_new_rating(user_id, food_truck_id)
  end

  def change_food_truck_rating(rating, attrs \\ %{}), do: FoodTruckRating.changeset(rating, attrs)

  def save_or_update_food_truck_rating(rating, attrs \\ %{}) do
    change_food_truck_rating(rating, attrs)
    |> Repo.insert_or_update()
  end

  def update_or_new_rating(nil, user_id, food_truck_id),
    do: %FoodTruckRating{user_id: user_id, food_truck_id: food_truck_id}

  def update_or_new_rating(rating, _user_id, _food_truck_id), do: rating
end
