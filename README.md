
Umb
===

** Phoenix umbrella apps **


Basic structure: 

```
umb
  ...apps
      ...rtr
      ...app1
      ...app2
      ...app_with_brunch
```

Rtr.Endpoint is what binds to our port, and it's router will directly call the modules for the other apps.  

We create routes that call the endpoints directly from rtr, and also ones forwarded to the endpoints.  If you need you assets compiled and served from your app, you need to use the forward approach.  This approach requires that you prepend your prefix route path to your asset paths.  This is because static_path/2 will not let you use a relative path.

commands to set this up:

```sh
mix new umb --umbrella
cd umb/apps
mix phoenix.new rtr --no-ecto
mix phoenix.new app1 --no-ecto --no-brunch
mix phoenix.new app2 --no-ecto --no-brunch
mix phoenix.new app_with_brunch --no-ecto
cd app_with_brunch
npm install
```

> then edit your apps/<app>/config/dev.exs and add this customized to your app name and endpoint: 

>app1
```elixir
config :app1, App1.Endpoint, server: false
```

>app2
```elixir
config :app2, App2.Endpoint, server: false
```

>app_with_brunch
```elixir
config :app_with_lunch, AppWithBrunch.Endpoint, server: false
```

Next we update our router, note we changed the scope module

```elixir
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
 
  # router doesnt' work well, Endpoint will be able to deal with assets
 
  forward "/app1", App1.Endpoint
  forward "/app2", App2.Endpoint

  # note you need to make sure your assets match this 
  forward "/ab", AppWithBrunch.Endpoint
```

The final step was to change apps/<app>/web/templates/page/index.html.eex so we can see the differences

```sh 
mix phoenix.server
... compiling stuff
Generated rtr app
[info] Running Rtr.Endpoint with Cowboy on http://localhost:4000
[error] Could not start node watcher because script "node_modules/brunch/bin/brunch" does not exist. Your Phoenix application is still running, however assets won't be compiled. You may fix this by running "npm install".
Interactive Elixir (1.0.5) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)>
```

You may need to run `mix phoenix.digest` and check to be sure your js and css assets are in apps/app_with_brunch/priv/static
You can test via curl

```sh
curl localhost:4000
curl localhost:4000/1
curl localhost:4000/2
curl localhost:4000/app1
curl localhost:4000/app2

# better to see this in a browser to see the js assets pulled in
curl localhost:4000/ab

```
