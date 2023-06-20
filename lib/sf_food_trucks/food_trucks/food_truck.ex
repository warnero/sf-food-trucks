defmodule SfFoodTrucks.FoodTrucks.FoodTruck do
  use Ecto.Schema
  import Ecto.Changeset

  alias SfFoodTrucks.FoodTrucks

  schema "food_trucks" do
    field :locationid, :string
    field :applicant, :string
    field :facility_type, :string
    field :status, Ecto.Enum, values: [:approved, :requested, :expired, :suspend]
    field :food_items, :string
    field :latitude, :float
    field :longitude, :float
    field :days_hours, :string
    field :avg_rating, :integer, virtual: true
    field :total_ratings, :integer, virtual: true

    has_many :ratings, FoodTrucks.FoodTruckRating

    timestamps()
  end

  @doc false
  def changeset(food_truck, attrs) do
    food_truck
    |> cast(attrs, [])
    |> validate_required([])
  end
end
