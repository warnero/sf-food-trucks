defmodule SfFoodTrucks.Repo.Migrations.CreateFoodTrucks do
  use Ecto.Migration

  def change do
    create table(:food_trucks) do
      add :locationid, :string
      add :applicant, :string
      add :facility_type, :string
      add :status, :string
      add :food_items, :string, size: 1000
      add :latitude, :float
      add :longitude, :float
      add :days_hours, :string

      timestamps()
    end
  end
end
