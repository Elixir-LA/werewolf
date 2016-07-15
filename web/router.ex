defmodule Werewolf.Router do
  use Werewolf.Web, :router

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

  scope "/", Werewolf do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/games", GameController
    resources "/users", UserController
    resources "/login", GameStartController, only: [:create]
    resources "/join", SessionController, only: [:create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Werewolf do
  #   pipe_through :api
  # end
end
