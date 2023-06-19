defmodule SfFoodTrucks.FoodTrucksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SfFoodTrucks.FoodTrucks` context.
  """

  @doc """
  Generate a food_truck.
  """
  def food_truck_fixture(attrs \\ %{}) do
    {:ok, food_truck} =
      attrs
      |> Enum.into(%{

      })
      |> SfFoodTrucks.FoodTrucks.create_food_truck()

    food_truck
  end
end
