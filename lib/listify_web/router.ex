defmodule ListifyWeb.Router do
  use ListifyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_auth do
    plug ListifyWeb.Plugs.Auth
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

  scope "/admin", ListifyWeb.Admin, as: :admin do
    pipe_through [:browser, :browser_auth]

    get "/", AdminController, :index

  end

  # Other scopes may use custom stacks.
  # scope "/api", ListifyWeb do
  #   pipe_through :api
  # end
end
