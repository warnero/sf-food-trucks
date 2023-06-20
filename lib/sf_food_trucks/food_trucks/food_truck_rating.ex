defmodule SfFoodTrucks.FoodTrucks.FoodTruckRating do
  use Ecto.Schema
  import Ecto.Changeset

  alias SfFoodTrucks.Accounts
  alias SfFoodTrucks.FoodTrucks

  schema "food_truck_ratings" do
    field :rating, :integer
    belongs_to :user, Accounts.User
    belongs_to :food_truck, FoodTrucks.FoodTruck

    timestamps()
  end

  @doc false
  def changeset(food_truck_rating, attrs \\ %{}) do
    food_truck_rating
    |> cast(attrs, [:rating])
    |> validate_required([:rating, :user_id, :food_truck_id])
  end
end
