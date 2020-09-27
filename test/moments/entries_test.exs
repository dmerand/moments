defmodule Moments.EntriesTest do
  use Moments.DataCase

  alias Moments.Entries

  describe "moments" do
    alias Moments.Entries.Moment

    @valid_attrs %{entry: "some entry", price: 120.5, type: "some type"}
    @update_attrs %{entry: "some updated entry", price: 456.7, type: "some updated type"}
    @invalid_attrs %{entry: nil, price: nil, type: nil}

    def moment_fixture(attrs \\ %{}) do
      {:ok, moment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Entries.create_moment()

      moment
    end

    test "list_moments/0 returns all moments" do
      moment = moment_fixture()
      assert Entries.list_moments() == [moment]
    end

    test "get_moment!/1 returns the moment with given id" do
      moment = moment_fixture()
      assert Entries.get_moment!(moment.id) == moment
    end

    test "create_moment/1 with valid data creates a moment" do
      assert {:ok, %Moment{} = moment} = Entries.create_moment(@valid_attrs)
      assert moment.entry == "some entry"
      assert moment.price == 120.5
      assert moment.type == "some type"
    end

    test "create_moment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Entries.create_moment(@invalid_attrs)
    end

    test "update_moment/2 with valid data updates the moment" do
      moment = moment_fixture()
      assert {:ok, %Moment{} = moment} = Entries.update_moment(moment, @update_attrs)
      assert moment.entry == "some updated entry"
      assert moment.price == 456.7
      assert moment.type == "some updated type"
    end

    test "update_moment/2 with invalid data returns error changeset" do
      moment = moment_fixture()
      assert {:error, %Ecto.Changeset{}} = Entries.update_moment(moment, @invalid_attrs)
      assert moment == Entries.get_moment!(moment.id)
    end

    test "delete_moment/1 deletes the moment" do
      moment = moment_fixture()
      assert {:ok, %Moment{}} = Entries.delete_moment(moment)
      assert_raise Ecto.NoResultsError, fn -> Entries.get_moment!(moment.id) end
    end

    test "change_moment/1 returns a moment changeset" do
      moment = moment_fixture()
      assert %Ecto.Changeset{} = Entries.change_moment(moment)
    end
  end
end
