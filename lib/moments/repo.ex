defmodule Moments.Repo do
  use Ecto.Repo,
    otp_app: :moments,
    adapter: Ecto.Adapters.Postgres
end
