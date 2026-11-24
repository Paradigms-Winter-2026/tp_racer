defmodule TpRacerWeb.AuthController do
  use TpRacerWeb, :controller
  plug Ueberauth

  alias TpRacer.Accounts
  alias TpRacerWeb.UserAuth

  def request(conn, _params), do: conn

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case Accounts.find_or_create_oauth_user(%{email: auth.info.email}) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome!")
        |> UserAuth.log_in_user(user)

      {:error, _} ->
        conn
        |> put_flash(:error, "Could not sign in with #{auth.provider}.")
        |> redirect(to: ~p"/users/register")
    end
  end

  def callback(%{assigns: %{ueberauth_failure: _}} = conn, _params) do
    conn
    |> put_flash(:error, "Authentication failed.")
    |> redirect(to: ~p"/users/register")
  end
end
