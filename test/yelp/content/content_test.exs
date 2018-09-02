defmodule Yelp.ContentTest do
  use Yelp.DataCase

  alias Yelp.Content

  describe "restaurants" do
    alias Yelp.Content.Restaurant

    @valid_attrs %{address1: "some address1", address2: "some address2", city: "some city", name: "some name", phone: "some phone", state: "some state", website: "some website"}
    @update_attrs %{address1: "some updated address1", address2: "some updated address2", city: "some updated city", name: "some updated name", phone: "some updated phone", state: "some updated state", website: "some updated website"}
    @invalid_attrs %{address1: nil, address2: nil, city: nil, name: nil, phone: nil, state: nil, website: nil}

    def restaurant_fixture(attrs \\ %{}) do
      {:ok, restaurant} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_restaurant()

      restaurant
    end

    test "list_restaurants/0 returns all restaurants" do
      restaurant = restaurant_fixture()
      assert Content.list_restaurants() == [restaurant]
    end

    test "get_restaurant!/1 returns the restaurant with given id" do
      restaurant = restaurant_fixture()
      assert Content.get_restaurant!(restaurant.id) == restaurant
    end

    test "create_restaurant/1 with valid data creates a restaurant" do
      assert {:ok, %Restaurant{} = restaurant} = Content.create_restaurant(@valid_attrs)
      assert restaurant.address1 == "some address1"
      assert restaurant.address2 == "some address2"
      assert restaurant.city == "some city"
      assert restaurant.name == "some name"
      assert restaurant.phone == "some phone"
      assert restaurant.state == "some state"
      assert restaurant.website == "some website"
    end

    test "create_restaurant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_restaurant(@invalid_attrs)
    end

    test "update_restaurant/2 with valid data updates the restaurant" do
      restaurant = restaurant_fixture()
      assert {:ok, restaurant} = Content.update_restaurant(restaurant, @update_attrs)
      assert %Restaurant{} = restaurant
      assert restaurant.address1 == "some updated address1"
      assert restaurant.address2 == "some updated address2"
      assert restaurant.city == "some updated city"
      assert restaurant.name == "some updated name"
      assert restaurant.phone == "some updated phone"
      assert restaurant.state == "some updated state"
      assert restaurant.website == "some updated website"
    end

    test "update_restaurant/2 with invalid data returns error changeset" do
      restaurant = restaurant_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_restaurant(restaurant, @invalid_attrs)
      assert restaurant == Content.get_restaurant!(restaurant.id)
    end

    test "delete_restaurant/1 deletes the restaurant" do
      restaurant = restaurant_fixture()
      assert {:ok, %Restaurant{}} = Content.delete_restaurant(restaurant)
      assert_raise Ecto.NoResultsError, fn -> Content.get_restaurant!(restaurant.id) end
    end

    test "change_restaurant/1 returns a restaurant changeset" do
      restaurant = restaurant_fixture()
      assert %Ecto.Changeset{} = Content.change_restaurant(restaurant)
    end
  end
end
