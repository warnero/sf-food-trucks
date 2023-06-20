defmodule SfFoodTrucks.Repo.Migrations.CreateFoodTruckRatings do
  use Ecto.Migration

  def change do
    create table(:food_truck_ratings) do
      add :rating, :integer
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :food_truck_id, references(:food_trucks, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:food_truck_ratings, [:user_id])
    create unique_index(:food_truck_ratings, [:user_id, :food_truck_id])
  end
end
