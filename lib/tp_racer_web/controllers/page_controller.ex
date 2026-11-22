defmodule TpRacerWeb.PageController do
  use TpRacerWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end

  def stats(conn, _params) do
    opts = [
      user_name: "sample",
      tests_started: 9999,
      tests_completed: 1,
      time_typing: 123
    ]
    render(conn, :stats, opts)
  end
end
