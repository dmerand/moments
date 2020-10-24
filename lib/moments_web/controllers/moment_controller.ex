defmodule MomentsWeb.MomentController do
  use MomentsWeb, :controller
  plug :authorize_page when action in [:new, :create, :delete, :edit, :update]

  alias Moments.Entries
  alias Moments.Entries.Moment

  def atom(conn, _params) do
    moments =
      Entries.list_moments(shuffle: false)
      |> Enum.sort_by(& &1.inserted_at)

    url = MomentsWeb.Endpoint.url()

    updated =
      moments
      |> Enum.map(& &1.inserted_at)
      |> Enum.max()

    render(conn, "atom.xml", moments: moments, updated: updated, url: url)
  end

  def create(conn, %{"moment" => moment_params}) do
    case Entries.create_moment(moment_params) do
      {:ok, _moment} ->
        conn
        # |> put_flash(:info, "Moment created successfully.")
        |> redirect(to: Routes.moment_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    moment = Entries.get_moment!(id)
    {:ok, _moment} = Entries.delete_moment(moment)

    conn
    # |> put_flash(:info, "Moment deleted successfully.")
    |> redirect(to: Routes.moment_path(conn, :index))
  end

  def edit(conn, %{"id" => id}) do
    moment = Entries.get_moment!(id)
    changeset = Entries.change_moment(moment)
    render(conn, "edit.html", moment: moment, changeset: changeset)
  end

  def index(conn, _params) do
    moments = Entries.list_moments()
    render(conn, "index.html", moments: moments, authenticated: conn.assigns.authenticated)
  end

  def new(conn, _params) do
    changeset = Entries.change_moment(%Moment{})
    render(conn, "new.html", changeset: changeset)
  end

  def update(conn, %{"id" => id, "moment" => moment_params}) do
    moment = Entries.get_moment!(id)

    case Entries.update_moment(moment, moment_params) do
      {:ok, _moment} ->
        conn
        # |> put_flash(:info, "Moment updated successfully.")
        |> redirect(to: Routes.moment_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", moment: moment, changeset: changeset)
    end
  end

  defp authorize_page(conn, _) do
    if conn.assigns.authenticated == true do
      conn
    else
      conn
      |> redirect(to: "/")
      |> halt()
    end
  end
end
