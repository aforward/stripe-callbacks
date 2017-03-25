defmodule StripeCallbacks.Repo.Migrations.AddTokens do
  use Ecto.Migration

  def change do
    create table(:tokens) do
      add :data, :map
      add :token_status, :string
      timestamps()
    end
  end
end





