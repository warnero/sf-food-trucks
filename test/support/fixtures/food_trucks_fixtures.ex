defmodule SfFoodTrucks.FoodTrucksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SfFoodTrucks.FoodTrucks` context.
  """

  alias SfFoodTrucks.Repo
  alias SfFoodTrucks.FoodTrucks.FoodTruck
  alias SfFoodTrucks.FoodTrucks.FoodTruckRating

  @doc """
  Generate a food_truck.
  """
  def food_truck_fixture(attrs \\ %{}) do
    {:ok, food_truck} =
      attrs
      |> Enum.into(%{})
      |> create_food_truck()

    food_truck
  end

  defp create_food_truck(attrs) do
    %FoodTruck{}
    |> FoodTruck.changeset(attrs)
    |> Repo.insert()
  end

  def food_truck_rating_fixture(user_id, food_truck_id, attrs \\ %{}) do
    {:ok, food_truck_rating} =
      attrs
      |> Enum.into(%{})
      |> (&create_food_truck_rating(user_id, food_truck_id, &1)).()

    food_truck_rating
  end

  defp create_food_truck_rating(user_id, food_truck_id, attrs) do
    %FoodTruckRating{user_id: user_id, food_truck_id: food_truck_id}
    |> FoodTruckRating.changeset(attrs)
    |> Repo.insert()
  end
end
