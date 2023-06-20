# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SfFoodTrucks.Repo.insert!(%SfFoodTrucks.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

defmodule FoodTruckDataFromJson do
  def read_file_and_insert do
    json_file = "#{__DIR__}/seeds/sf_food_trucks.json"

    File.read!(json_file)
    |> Jason.decode!(keys: :strings)
    |> Enum.map(fn truck -> filtered_data(truck) end)
    |> Enum.map(fn truck -> SfFoodTrucks.Repo.insert(truck) end)
  end

  defp filtered_data(truck_data) do
    with {:ok, locationid} <- fetch_in(truck_data, ["objectid"]),
         {:ok, applicant} <- fetch_in(truck_data, ["applicant"]),
         {:ok, facility_type} <- fetch_in(truck_data, ["facilitytype"]),
         {:ok, status} <- fetch_in(truck_data, ["status"]),
         {:ok, food_items} <- fetch_in(truck_data, ["fooditems"]),
         {:ok, latitude} <- fetch_in(truck_data, ["latitude"]),
         {:ok, longitude} <- fetch_in(truck_data, ["longitude"]),
         {:ok, days_hours} <- fetch_in(truck_data, ["dayshours"]) do
      enum_status =
        case status do
          "APPROVED" -> :approved
          "REQUESTED" -> :requested
          "EXPIRED" -> :expired
          "SUSPEND" -> :suspend
          _ -> :suspend
        end

      {latitude, _} = Float.parse(latitude)
      {longitude, _} = Float.parse(longitude)

      %SfFoodTrucks.FoodTruck{
        locationid: locationid,
        applicant: applicant,
        facility_type: facility_type,
        status: enum_status,
        food_items: food_items,
        latitude: latitude,
        longitude: longitude,
        days_hours: days_hours
      }
    end
  end

  defp fetch_in(params, keys) do
    case get_in(params, keys) do
      nil ->
        {:ok, nil}

      value ->
        {:ok, value}
    end
  end
end

FoodTruckDataFromJson.read_file_and_insert()
