defmodule Ticketee.PageController do
  use Ticketee.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
