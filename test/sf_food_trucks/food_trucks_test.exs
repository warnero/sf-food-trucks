defmodule SfFoodTrucks.FoodTrucksTest do
  use SfFoodTrucks.DataCase

  alias SfFoodTrucks.FoodTrucks

  describe "food_trucks" do
    alias SfFoodTrucks.FoodTrucks.FoodTruck
    alias SfFoodTrucks.FoodTrucks.FoodTruckRating

    import SfFoodTrucks.FoodTrucksFixtures
    import SfFoodTrucks.AccountsFixtures

    @invalid_attrs %{}

    test "list_food_trucks/0 returns all food_trucks" do
      food_truck = food_truck_fixture()
      assert FoodTrucks.list_food_trucks() == [food_truck]
    end

    test "get_food_truck!/1 returns the food_truck with given id" do
      food_truck = food_truck_fixture()
      assert FoodTrucks.get_food_truck!(food_truck.id) == food_truck
    end

    test "get_food_truck_rating/2" do
      food_truck = food_truck_fixture()
      user = user_fixture()
      attrs = %{rating: 1}
      food_truck_rating = food_truck_rating_fixture(user.id, food_truck.id, attrs)
      assert FoodTrucks.get_food_truck_rating(food_truck.id, user.id) == food_truck_rating
    end

    test "save_or_update_food_truck_rating/2 saves a food truck rating" do
      food_truck = food_truck_fixture()
      user = user_fixture()
      attrs = %{rating: 1}
      rating = %FoodTruckRating{user_id: user.id, food_truck_id: food_truck.id}

      assert {:ok, %FoodTruckRating{}} =
               FoodTrucks.save_or_update_food_truck_rating(rating, attrs)
    end

    test "change_food_truck_rating/1 returns a food_truck_rating changeset" do
      food_truck = food_truck_fixture()
      user = user_fixture()
      food_truck_rating = food_truck_rating_fixture(user.id, food_truck.id, %{rating: 1})
      assert %Ecto.Changeset{} = FoodTrucks.change_food_truck_rating(food_truck_rating)
    end
  end
end
