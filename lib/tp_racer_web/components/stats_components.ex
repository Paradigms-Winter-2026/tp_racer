defmodule TpRacerWeb.StatsComponents do
  use Phoenix.Component
  use Gettext, backend: TpRacerWeb.Gettext

  # idk might need this later
  # alias Phoenix.LiveView.JS

  
  @doc """
    Username, displayed before the overall stat cards
  """
  attr :user_name, :string, required: true
  def user_info(assigns) do
    ~H"""
    <div class="flex flex-col rounded-md p-4">
      <p class="text-lg">{@user_name}</p>
    </div>
    """
  end

  @doc """
    Basic stat card component.
  """
  attr :label, :string, required: true
  attr :value, :any,    required: true
  def stat_card(assigns) do
    ~H"""
    <div class="flex flex-col rounded-md p-4">
      <p class="text-md">{@label}</p>
      <p class="text-lg font-bold">{@value}</p>
    </div>
    """
  end

  @doc """
    Row for a single game, displayed before the overall stat cards
  """
  attr :wpm, :integer, required: true
  attr :raw, :integer, required: true
  attr :accuracy, :integer, required: true
  attr :dt, :any, required: true
  attr :colour, :string, required: true
  def game_info(assigns) do
    assigns = assign(
    assigns, :colour,
    unless(rem(assigns.index, 2) == 0, 
        do: "bg-slate-800", 
        else: ""
    ))
    ~H"""
    <tr class={@colour}>
      <td class="text-lg">{@wpm}</td>
      <td class="text-lg">{@raw}</td>
      <td class="text-lg">{@accuracy}</td>
      <td class="text-md flex flex-col my-2">
        <p class="text-lg">{@dt.date}</p>
        <p class="text-sm">{@dt.time}</p>
      </td>
    </tr>
    """
  end

  @doc """
    A table of games
  """
  attr :games, :list, required: true
  def games(assigns) do
    # TODO: add filter for games completed
    ~H"""
    <div class="flex flex-col">
    <p class="text-xl my-2">games</p>
    <table>
      <tr>
        <th class="text-left">wpm</th>
        <th class="text-left">raw</th>
        <th class="text-left">accuracy</th>
        <th class="text-left">date</th>
      </tr>
      <%= for {game, index} <- Enum.with_index(@games) do %>
          <.game_info {game} index={index} />
      <% end %>
    </table>
    </div>
    """
  end
end
