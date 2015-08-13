defmodule Rtr.Router do
  use Rtr.Web, :router

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

  scope "/", Rtr do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end
  scope "/1",App1 do
    pipe_through :browser
    get "/", PageController, :index
  end
  scope "/2",App2 do
    pipe_through :browser
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Rtr do
  #   pipe_through :api
  # end
end
