defmodule MomentsWeb.MomentControllerTest do
  use MomentsWeb.ConnCase

  alias Moments.Entries

  @create_attrs %{entry: "some entry", price: 120.5, type: "some type"}
  @update_attrs %{entry: "some updated entry", price: 456.7, type: "some updated type"}
  @invalid_attrs %{entry: nil, price: nil, type: nil}

  def fixture(:moment) do
    {:ok, moment} = Entries.create_moment(@create_attrs)
    moment
  end

  describe "index" do
    test "lists all moments", %{conn: conn} do
      conn = get(conn, Routes.moment_path(conn, :index))
      assert html_response(conn, 200) =~ "Catalog of Moments"
    end
  end

  describe "new moment" do
    setup [:authenticate]

    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.moment_path(conn, :new))
      assert html_response(conn, 200) =~ "New Moment"
    end
  end

  describe "create moment" do
    setup [:authenticate]

    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.moment_path(conn, :create), moment: @create_attrs)

      assert redirected_to(conn) == Routes.moment_path(conn, :index)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.moment_path(conn, :create), moment: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Moment"
    end
  end

  describe "edit moment" do
    setup [:authenticate, :create_moment]

    test "renders form for editing chosen moment", %{conn: conn, moment: moment} do
      conn = get(conn, Routes.moment_path(conn, :edit, moment))
      assert html_response(conn, 200) =~ "Moment"
    end
  end

  describe "update moment" do
    setup [:authenticate, :create_moment]

    test "redirects when data is valid", %{conn: conn, moment: moment} do
      conn = put(conn, Routes.moment_path(conn, :update, moment), moment: @update_attrs)
      assert redirected_to(conn) == Routes.moment_path(conn, :index)
    end

    test "renders errors when data is invalid", %{conn: conn, moment: moment} do
      conn = put(conn, Routes.moment_path(conn, :update, moment), moment: @invalid_attrs)
      assert html_response(conn, 200) =~ "Oops"
    end
  end

  describe "delete moment" do
    setup [:authenticate, :create_moment]

    test "deletes chosen moment", %{conn: conn, moment: moment} do
      conn = delete(conn, Routes.moment_path(conn, :delete, moment))
      assert redirected_to(conn) == Routes.moment_path(conn, :index)
    end
  end

  defp authenticate(%{conn: conn}) do
    %{conn: get(conn, Routes.authentication_path(conn, :show, "🔥"))}
  end

  defp create_moment(_) do
    moment = fixture(:moment)
    %{moment: moment}
  end
end
