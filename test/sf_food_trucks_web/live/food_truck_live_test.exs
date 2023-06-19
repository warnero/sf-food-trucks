defmodule SfFoodTrucksWeb.FoodTruckLiveTest do
  use SfFoodTrucksWeb.ConnCase

  import Phoenix.LiveViewTest
  import SfFoodTrucks.FoodTrucksFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_food_truck(_) do
    food_truck = food_truck_fixture()
    %{food_truck: food_truck}
  end

  describe "Index" do
    setup [:create_food_truck]

    test "lists all food_trucks", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/food_trucks")

      assert html =~ "Listing Food trucks"
    end

    test "saves new food_truck", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/food_trucks")

      assert index_live |> element("a", "New Food truck") |> render_click() =~
               "New Food truck"

      assert_patch(index_live, ~p"/food_trucks/new")

      assert index_live
             |> form("#food_truck-form", food_truck: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#food_truck-form", food_truck: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/food_trucks")

      html = render(index_live)
      assert html =~ "Food truck created successfully"
    end

    test "updates food_truck in listing", %{conn: conn, food_truck: food_truck} do
      {:ok, index_live, _html} = live(conn, ~p"/food_trucks")

      assert index_live |> element("#food_trucks-#{food_truck.id} a", "Edit") |> render_click() =~
               "Edit Food truck"

      assert_patch(index_live, ~p"/food_trucks/#{food_truck}/edit")

      assert index_live
             |> form("#food_truck-form", food_truck: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#food_truck-form", food_truck: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/food_trucks")

      html = render(index_live)
      assert html =~ "Food truck updated successfully"
    end

    test "deletes food_truck in listing", %{conn: conn, food_truck: food_truck} do
      {:ok, index_live, _html} = live(conn, ~p"/food_trucks")

      assert index_live |> element("#food_trucks-#{food_truck.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#food_trucks-#{food_truck.id}")
    end
  end

  describe "Show" do
    setup [:create_food_truck]

    test "displays food_truck", %{conn: conn, food_truck: food_truck} do
      {:ok, _show_live, html} = live(conn, ~p"/food_trucks/#{food_truck}")

      assert html =~ "Show Food truck"
    end

    test "updates food_truck within modal", %{conn: conn, food_truck: food_truck} do
      {:ok, show_live, _html} = live(conn, ~p"/food_trucks/#{food_truck}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Food truck"

      assert_patch(show_live, ~p"/food_trucks/#{food_truck}/show/edit")

      assert show_live
             |> form("#food_truck-form", food_truck: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#food_truck-form", food_truck: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/food_trucks/#{food_truck}")

      html = render(show_live)
      assert html =~ "Food truck updated successfully"
    end
  end
end
