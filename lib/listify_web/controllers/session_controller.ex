defmodule ListifyWeb.SessionController do
  use ListifyWeb, :controller

  alias Listify.Accounts

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => auth_params}) do
    user = Accounts.get_by_email(auth_params["email"])
    case Bcrypt.check_pass(user, auth_params["password"]) do
    {:ok, user} ->
      conn
      |> put_session(:current_user_id, user.id)
      |> put_flash(:info, "Signed in Successfully")
      |> redirect(to: Routes.admin_admin_path(conn, :index))
    {:error, _} ->
      conn
        |> put_flash(:error, "There was a problem with your username or password")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:current_user_id)
    |> put_flash(:info, "Signed Out Successfully")
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
