defmodule ListifyWeb.PlaylistController do
  use ListifyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
