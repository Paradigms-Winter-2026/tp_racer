defmodule TpRacerWeb.StatsComponents do
  use Phoenix.Component
  use Gettext, backend: TpRacerWeb.Gettext

  # idk might need this later
  # alias Phoenix.LiveView.JS
  
  @doc """
    Component for the stats of the current user.
  """
  def main_user_stats(assigns) do
    ~H"""
      <div class="flex flex-row">
        <p><%= assigns[:user_name] %></p>
        <div class="flex flex-col">
          <p>tests started</p>
          <%= assigns[:tests_started] %>
        </div>
        <div class="flex flex-col">
          <p>tests completed</p>
          <%= assigns[:tests_completed] %>
        </div>
      </div>
    """
  end
end
