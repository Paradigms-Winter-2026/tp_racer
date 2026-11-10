defmodule TpRacer.Repo do
  use Ecto.Repo,
    otp_app: :tp_racer,
    adapter: Ecto.Adapters.Postgres
end
