defmodule SfFoodTrucksWeb.FoodTruckLive.Index do
  use SfFoodTrucksWeb, :live_view

  alias SfFoodTrucks.FoodTrucks

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :food_trucks, FoodTrucks.list_food_trucks())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :rate, %{"id" => id}) do
    id = String.to_integer(id)

    socket
    |> assign(:page_title, "Rate Food truck")
    |> assign(
      :food_truck_rating,
      FoodTrucks.get_food_truck_rating(id, socket.assigns.current_user.id)
    )
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Food trucks")
    |> assign(:food_truck, nil)
  end

  @impl true
  def handle_info({SfFoodTrucksWeb.FoodTruckLive.FormComponent, {:saved, food_truck}}, socket) do
    {:noreply, stream_insert(socket, :food_trucks, food_truck)}
  end
end
