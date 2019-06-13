defmodule ListifyWeb.Helpers.Auth do
  alias Listify.Repo
  alias Listify.Accounts.User
  def current_user(conn) do
    user_id = Plug.Conn.get_session(conn, :current_user_id)
    if user_id, do: Repo.get(User,  user_id)
    nil
  end
end
