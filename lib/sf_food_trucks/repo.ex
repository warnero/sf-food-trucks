defmodule SfFoodTrucks.Repo do
  use Ecto.Repo,
    otp_app: :sf_food_trucks,
    adapter: Ecto.Adapters.Postgres
end
