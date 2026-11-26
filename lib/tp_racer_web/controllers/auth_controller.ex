defmodule TpRacerWeb.AuthController do
  use TpRacerWeb, :controller
  plug Ueberauth

  alias TpRacer.Accounts
  alias TpRacerWeb.UserAuth

  def request(conn, _params), do: conn

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    with {:ok, email} <- verified_email(auth),
         {:ok, user} <- Accounts.find_or_create_oauth_user(%{email: email}) do
      conn
      |> put_flash(:info, "Welcome!")
      |> UserAuth.log_in_user(user)
    else
      {:error, :unverified_email} ->
        conn
        |> put_flash(:error, "Your #{auth.provider} email isn't verified.")
        |> redirect(to: ~p"/users/register")

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

  # for google we just check `email_verified` that they give us
  defp verified_email(%{provider: :google, info: %{email: email}, extra: %{raw_info: %{user: u}}}) do
    if u["email_verified"] == true, do: {:ok, email}, else: {:error, :unverified_email}
  end

  # github accounts can have multiple emails which can be unverified so to
  # verify we search for emails that are both flagged as primary and verified
  defp verified_email(%{provider: :github, extra: %{raw_info: %{user: u}}}) do
    case Enum.find(u["emails"] || [], &(&1["primary"] && &1["verified"])) do
      %{"email" => email} -> {:ok, email}
      nil -> {:error, :unverified_email}
    end
  end

  # Anything else (other provider, weird payload)
  defp verified_email(_auth), do: {:error, :unverified_email}
end
