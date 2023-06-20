defmodule SfFoodTrucksWeb.FoodTruckLiveTest do
  use SfFoodTrucksWeb.ConnCase

  import Phoenix.LiveViewTest
  import SfFoodTrucks.FoodTrucksFixtures
  import SfFoodTrucks.AccountsFixtures

  @valid_attrs %{rating: 2}
  @invalid_attrs %{}

  defp create_food_truck(_) do
    food_truck = food_truck_fixture()
    %{food_truck: food_truck}
  end

  describe "Index" do
    setup [:create_food_truck]

    test "lists all food_trucks", %{conn: conn} do
      {:ok, _index_live, html} =
        conn
        |> log_in_user(user_fixture())
        |> live(~p"/food_trucks")

      assert html =~ "Listing Food trucks"
    end

    test "rates food_truck in listing", %{conn: conn, food_truck: food_truck} do
      {:ok, index_live, _html} =
        conn
        |> log_in_user(user_fixture())
        |> live(~p"/food_trucks")

      assert index_live |> element("#food_trucks-#{food_truck.id} a", "Rate") |> render_click() =~
               "Rate Food truck"

      assert_patch(index_live, ~p"/food_trucks/#{food_truck}/rate")

      assert index_live
             |> form("#food_truck_rating-form", food_truck_rating: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#food_truck_rating-form", food_truck_rating: @valid_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/food_trucks")

      html = render(index_live)
      assert html =~ "Food truck rating updated successfully"
    end
  end
end
