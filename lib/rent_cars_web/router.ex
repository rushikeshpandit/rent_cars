defmodule RentCarsWeb.Router do
  use RentCarsWeb, :router
  alias RentCarsWeb.Middleware.EnsureAuthenticated
  alias RentCarsWeb.Middleware.IsAdmin

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {RentCarsWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RentCarsWeb do
    pipe_through :browser
  end

  pipeline :is_admin do
    plug IsAdmin
  end

  pipeline :authenticated do
    plug EnsureAuthenticated
  end

  # Other scopes may use custom stacks.
  scope "/api", RentCarsWeb.Api, as: :api do
    pipe_through :api

    scope "/admin", Admin, as: :admin do
      pipe_through :is_admin

      resources "/categories", CategoryController
      resources "/specifications", SpecificationController

      post "/car", CarController, :create
      put "/car/:id", CarController, :update
      get "/car/:id", CarController, :show
    end

    scope "/" do
      pipe_through :authenticated
      post "/session/me", SessionController, :me
      get "/users/:id", UserController, :show
    end

    post "/users", UserController, :create
    post "/session", SessionController, :create
    post "/session/forgot_password", SessionController, :forgot_password
    post "/session/reset_password", SessionController, :reset_password
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:rent_cars, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: RentCarsWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
