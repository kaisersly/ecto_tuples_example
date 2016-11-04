defmodule EctoTuplesExample.PageController do
  use EctoTuplesExample.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
