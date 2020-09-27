defmodule MomentsWeb.AuthenticationController do
  use MomentsWeb, :controller
  alias MomentsWeb.Authentication

  def delete(conn, _params) do
    conn = delete_session(conn, :authenticated)
    redirect(conn, to: "/")
  end

  def show(conn, %{"id" => id}) do
    if Authentication.check_token(id) do
      conn = put_session(conn, :authenticated, true)
      redirect(conn, to: Routes.moment_path(conn, :new))
    else
      redirect(conn, to: "/")
    end
  end
end
