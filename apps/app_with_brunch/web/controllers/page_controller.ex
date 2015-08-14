defmodule AppWithBrunch.PageController do
  use AppWithBrunch.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
