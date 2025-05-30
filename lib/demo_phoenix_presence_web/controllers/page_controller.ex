defmodule DemoPhoenixPresenceWeb.PageController do
  use DemoPhoenixPresenceWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
