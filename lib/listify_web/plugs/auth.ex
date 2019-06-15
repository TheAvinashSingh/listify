defmodule ListifyWeb.Plugs.Auth do
  import Plug.Conn
  alias Listify.Accounts
  alias ListifyWeb.Router.Helpers
  import Phoenix.Controller
  def init(default), do: default

  def call(conn, _default) do
    requires_auth(conn, _default)
  end
  def requires_auth(conn, _args) do
    if user_id = get_session(conn, :current_user_id) do
      current_user = Accounts.get_user!(user_id)

      conn
        |> assign(:current_user, current_user)
    else
      conn
        |> put_flash(:error, "You need to be signed in to access that page.")
        |> redirect(to: Helpers.session_path(conn, :new))
        |> halt( )
    end
  end
end
