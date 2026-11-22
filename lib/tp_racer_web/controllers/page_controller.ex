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
      time_typing: "12:34:56",
      games: [
        %{
          wpm: 123, 
          raw: 123, 
          accuracy: 0.1, 
          dt: %{date: "2026-11-22", time: "00:00"}
        },
        %{
          wpm: 98, 
          raw: 123, 
          accuracy: 0.1, 
          dt: %{date: "2026-11-22", time: "00:00"}
        },
        %{
          wpm: 1, 
          raw: 123, 
          accuracy: 0.1, 
          dt: %{date: "2026-11-22", time: "00:00"}
        }
      ]
    ]
    render(conn, :stats, opts)
  end
end
