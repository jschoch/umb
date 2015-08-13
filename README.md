Umb
===

** Phoenix umbrella apps **


Basic structure: 

umb

  └──apps
  
      └──rtr
      
      └──app1
      
      └──app2




commands to do this

```sh
mix new umb --umbrella
mix phoenix.new rtr --no-ecto
mix phoenix.new app1 --no-ecto --no-brunch
mix phoenix.new app2 --no-ecto --no-brunch
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

You can test via curl

```sh
curl localhost:4000
curl localhost:4000/1
curl localhost:4000/2
```

