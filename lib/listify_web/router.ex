defmodule ListifyWeb.Router do
  use ListifyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ListifyWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources "/playlists", PlaylistController
    resources "/registrations", UserController, only: [:create, :new]

    get "/sign-in", SessionController, :new
    post "/sign-in", SessionController, :create
    delete "/sign-out", SessionController, :delete

  end

  # Other scopes may use custom stacks.
  # scope "/api", ListifyWeb do
  #   pipe_through :api
  # end
end
