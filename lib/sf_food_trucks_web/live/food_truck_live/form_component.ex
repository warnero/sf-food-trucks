defmodule SfFoodTrucksWeb.FoodTruckLive.FormComponent do
  use SfFoodTrucksWeb, :live_component

  alias SfFoodTrucks.FoodTrucks

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to rate a Food Truck</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="food_truck_rating-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.error :if={@form.errors != []}>
          Oops, something went wrong! Please check the errors below.
        </.error>
        <.input
          field={@form[:rating]}
          type="select"
          label="Rate (1 - 5)"
          prompt="Choose a number between 1 and 5"
          options={["1": "1", "2": "2", "3": "3", "4": "4", "5": "5"]}
          value={@food_truck_rating.rating}
          required
        />

        <:actions>
          <.button phx-disable-with="Saving...">Save Food truck rating</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{food_truck_rating: food_truck_rating} = assigns, socket) do
    changeset = FoodTrucks.change_food_truck_rating(food_truck_rating)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"food_truck_rating" => food_truck_rating_params}, socket) do
    changeset =
      socket.assigns.food_truck_rating
      |> FoodTrucks.change_food_truck_rating(food_truck_rating_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"food_truck_rating" => food_truck_rating_params}, socket) do
    save_food_truck_rating(socket, food_truck_rating_params)
  end

  defp save_food_truck_rating(socket, food_truck_rating_params) do
    case FoodTrucks.save_or_update_food_truck_rating(
           socket.assigns.food_truck_rating,
           food_truck_rating_params
         ) do
      {:ok, food_truck_rating} ->
        notify_parent({:saved, FoodTrucks.get_food_truck!(food_truck_rating.food_truck_id)})

        {:noreply,
         socket
         |> put_flash(:info, "Food truck rating updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
