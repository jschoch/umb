Umb
===

** Phoenix umbrella apps **


Basic structure: 

umb
  └──apps
      └──rtr
      └──app1
      └──app2

app1..1 and app_with_brunch have configs updated to prevent the endpoint from binding to a port (dev.exs)

```elixir
config :app1, App1.Endpoint, server: false
```


commands to do this

```sh
mix new umb --umbrella
mix phoenix.new rtr --no-ecto
mix phoenix.new app1 --no-ecto --no-brunch
mix phoenix.new app2 --no-ecto --no-brunch
mix phoenix.new app_with_brunch --no-ecto
```

> then edit your app/config/dev.exs per above

```sh 
mix phoenix.server
... compiling stuff
Generated rtr app
[info] Running Rtr.Endpoint with Cowboy on http://localhost:4000
[error] Could not start node watcher because script "node_modules/brunch/bin/brunch" does not exist. Your Phoenix application is still running, however assets won't be compiled. You may fix this by running "npm install".
Interactive Elixir (1.0.5) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)>
```


to get your assets working you need to change your layout to match your router config.  In this case we prepend "/ab" to the static_path for both app.css and app.js
