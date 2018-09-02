defmodule YelpWeb.RestaurantController do
  use YelpWeb, :controller

  alias Yelp.Content
  alias Yelp.Content.Restaurant

  action_fallback YelpWeb.FallbackController

  def index(conn, _params) do
    restaurants = Content.list_restaurants()
    render(conn, "index.json", restaurants: restaurants)
  end

  def create(conn, %{"restaurant" => restaurant_params}) do
    with {:ok, %Restaurant{} = restaurant} <- Content.create_restaurant(restaurant_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", restaurant_path(conn, :show, restaurant))
      |> render("show.json", restaurant: restaurant)
    end
  end

  def show(conn, %{"id" => id}) do
    restaurant = Content.get_restaurant!(id)
    render(conn, "show.json", restaurant: restaurant)
  end

  def update(conn, %{"id" => id, "restaurant" => restaurant_params}) do
    restaurant = Content.get_restaurant!(id)

    with {:ok, %Restaurant{} = restaurant} <- Content.update_restaurant(restaurant, restaurant_params) do
      render(conn, "show.json", restaurant: restaurant)
    end
  end

  def delete(conn, %{"id" => id}) do
    restaurant = Content.get_restaurant!(id)
    with {:ok, %Restaurant{}} <- Content.delete_restaurant(restaurant) do
      send_resp(conn, :no_content, "")
    end
  end
end
