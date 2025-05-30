defmodule DemoPhoenixPresence.Repo do
  use Ecto.Repo,
    otp_app: :demo_phoenix_presence,
    adapter: Ecto.Adapters.Postgres
end
